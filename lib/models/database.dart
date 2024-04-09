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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(categories, categories.icon);
        }
        // if (from < 3) {
        //   // we added the priority property in the change from version 1 or 2
        //   // to version 3
        //   await m.addColumn(categories, categories.);
        // }
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

  Future<Saldo?> getFirstSaldo() async {
  final query = select(saldos)..limit(1);
  final result = await query.get();
  if (result.isNotEmpty) {
    return result.first;
  } else {
    return null;
  }
}

Future<void> createOrUpdateSaldo(int saldo) async {
  // Ambil hanya satu baris pertama dari tabel saldo
  final query = await (select(saldos)).get();

  if (query.isEmpty) {
    // Jika tidak ada data saldo, tambahkan data baru
    await into(saldos).insert(SaldosCompanion.insert(saldo: saldo));
    print("Data saldo berhasil ditambahkan.");
  } else {
    // Jika data saldo sudah ada, perbarui saldo yang ada
    await (update(saldos)..where((tbl) => tbl.id.equals(query.first.id)))
        .write(SaldosCompanion(saldo: Value(saldo)));
    print("Data saldo berhasil diperbarui.");
  }
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
