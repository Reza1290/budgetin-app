import 'dart:io';

import 'package:budgetin/models/category.dart';
import 'package:budgetin/models/saldo.dart';
import 'package:budgetin/models/transaction.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [Categories, Transactions, Saldos],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
          await into(saldos)
              .insert(SaldosCompanion.insert(id: Value(1), saldo: 0));
        }
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(categories, categories.icon);
        }
        if (from < 3) {
          await m.createTable($SaldosTable(attachedDatabase));
        }
      },
    );
  }

  Future<int> insertCategory(CategoriesCompanion entry) async {
    return await into(categories).insert(entry);
  }

  Future<List<Category>> allCategories() async {
    return await select(categories).get();
  }

  Future<Category> getCategory(int id) async {
    return await (select(categories)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateCategory(CategoriesCompanion entry) async {
    return await update(categories).replace(entry);
  }

  Future<void> deleteCategory(int id) async {
    await (delete(categories)..where((tbl) => tbl.id.equals(id)))
        .go()
        .then((value) {
      (delete(transactions)..where((tbl) => tbl.category_id.equals(id))).go();
    });
  }

  Stream<List<TransactionWithCategory>> getAllTransactionWithCategory() {
    final query = (select(transactions)).join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id))
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
            row.readTable(transactions), row.readTable(categories));
      }).toList();
    });
  }

  Stream<List<TransactionWithCategory>> getTransactionWithCategoryLimit(
      int limit) {
    final query = select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id)),
    ]);
    query.limit(limit);
    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
            row.readTable(transactions), row.readTable(categories));
      }).toList();
    });
  }

  Stream<List<TransactionWithCategory>> getTransactionWithCategory(int id) {
    final query = select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id)),
    ])
      ..where(categories.id.equals(id));

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
            row.readTable(transactions), row.readTable(categories));
      }).toList();
    });
  }

  Future<int> insertTransaction(TransactionsCompanion entry) async {
    return await into(transactions).insert(entry);
  }

  Future<List<Transaction>> allTransactions() async {
    return await select(transactions).get();
  }

  Future<Transaction> getTransaction(int id) async {
    return await (select(transactions)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future updateTransactionRepo(int id, String name, int amount, int categoryId,
      String description, DateTime date) async {
    return (update(transactions)..where((tbl) => tbl.id.equals(id))).write(
        TransactionsCompanion(
            name: Value(name),
            description: Value(description),
            category_id: Value(categoryId),
            amount: Value(amount),
            transaction_date: Value(date)));
  }

  Future<int> deleteTransaction(int id) async {
    return await (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> sumExpenseCategory(int categoryId) async {
    final datas = await (select(transactions)
          ..where((tbl) => tbl.category_id.equals(categoryId)))
        .get();
    int totalAmount = 0;

    for (final data in datas) {
      totalAmount += data.amount;
    }

    return totalAmount;
  }

  Stream<List<CategoryTotal>> sumExpenseByCategory(int limit) {
    final categoriesResultStream = limit != 0
        ? (select(categories)..limit(limit)).watch()
        : select(categories).watch();

    return categoriesResultStream.asyncMap((categoriesResult) async {
      final List<CategoryTotal> categoryTotals = [];

      for (final category in categoriesResult) {
        final totalAmount = await _calculateTotalAmountForCategory(category.id);
        categoryTotals.add(CategoryTotal(category, totalAmount));
      }

      return categoryTotals;
    });
  }

  Future<int> sumUsedSaldo() async {
    int total = 0;
    final rows = await select(categories).get();
    total =
        rows.map((e) => e.total).fold(0, (acc, value) => acc + (value ?? 0));
    return total;
  }

  Stream<int> watchUsedSaldo() async* {
    int total = 0;
    final rows = await select(categories).get();
    total =
        rows.map((e) => e.total).fold(0, (acc, value) => acc + (value ?? 0));
    yield total;
  }

  Stream<int> watchRemainSaldo() async* {
    int total = 0;
    final rows = await select(categories).get();
    total =
        rows.map((e) => e.total).fold(0, (acc, value) => acc + (value ?? 0));
    int sal = await getFirstSaldo().then((value) => value.saldo);
    yield sal - total;
  }

  Future<int> _calculateTotalAmountForCategory(int categoryId) async {
    final datas = await (select(transactions)
          ..where((tbl) => tbl.category_id.equals(categoryId)))
        .get();
    int totalAmount = 0;

    for (final data in datas) {
      totalAmount += data.amount;
    }

    return totalAmount;
  }

  Future<Saldo> getFirstSaldo() async {
    final query = select(saldos)..limit(1);
    final result = await query.get();
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return Saldo(id: 1, saldo: 0);
    }
  }

  Stream<Saldo> watchFirstSaldo() {
    return (select(saldos)
          ..orderBy([
            // (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .watchSingle(); // Use watchSingle to get a stream of a single item
  }

  Future<int> createOrUpdateSaldo(int saldo) async {
    return into(saldos).insertOnConflictUpdate(
        SaldosCompanion.insert(id: Value(1), saldo: saldo));
  }

  Stream<int> totalExpense() async* {
    final datas = await allTransactions();
    int totalExpense = 0;

    for (final data in datas) {
      totalExpense += data.amount;
      yield totalExpense;
    }
  }
}

class CategoryTotal {
  final Category category;
  final int totalAmount;

  CategoryTotal(this.category, this.totalAmount);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}
