import 'dart:io';

import 'package:budgetin/models/category.dart';
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
  tables: [Categories, Transactions],
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

  Future<int> deleteCategory(int id) async {
    return await (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TransactionWithCategory>> getAllTransactionWithCategory(){
    final query = (select(transactions)).join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id))
    ]);
    return query.watch().map((rows){
      return rows.map((row){
        return TransactionWithCategory(
          row.readTable(transactions),
          row.readTable(categories)
        );
      } ).toList();
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

  

  Future updateTransactionRepo(int id, String name, int amount, int categoryId, String description, DateTime date) async{
    return (update(transactions)..where((tbl) => tbl.id.equals(id))).write(TransactionsCompanion(
      name: Value(name),
      description: Value(description),
      category_id: Value(categoryId),
      amount: Value(amount),
      transaction_date: Value(date)
    ));
  }

  Future<int> deleteTransaction(int id) async {
    return await (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future sumExpenseByCategory(int categoryId) async {
    final datas = await (select(transactions)..where((tbl) => tbl.category_id.equals(categoryId))).get();
    int totalAmount = 0;

    for (final data in datas) {
      totalAmount += data.amount;
    }

    return totalAmount;
  }

  Future totalExpense() async{
    final datas = await allTransactions();

    int totalExpense = 0;

    for (final data in datas) {
      totalExpense += data.amount;
    }

    return totalExpense;
  }
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
