import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:budgetin/models/category.dart';
import 'package:budgetin/models/detail_kategori.dart';
import 'package:budgetin/models/saldo.dart';
import 'package:budgetin/models/saldo_data.dart';
import 'package:budgetin/models/statistic_category.dart';
import 'package:budgetin/models/statistic_data.dart';
import 'package:budgetin/models/app_version.dart';
import 'package:budgetin/models/transaction.dart';
import 'package:budgetin/models/transaction_insert.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/models/user_tracker.dart';
import 'package:budgetin/models/variable.dart';
import 'package:budgetin/providers/random_color.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:uuid/v4.dart';
import 'package:uuid/v5.dart';

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [
    Categories,
    Transactions,
    Saldos,
    BudgetinVariables,
    AppVersions,
    UserTrackers
  ],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        String currentVersion = '1.0.0'; // Change this as needed
        await into(appVersions)
            .insert(AppVersionsCompanion.insert(version: currentVersion));
        print("ttest");
      },
      beforeOpen: (details) async {
        final currentVersion = '1.0.0'; // Change this as needed
        final version = await select(appVersions).getSingleOrNull();
        print(version);
        if (version == null || version.version != currentVersion) {
          // Clear data if version is different or not found
          print("ttest" + version.toString());

          await clearAllTables();
          // Insert or update the version
          if (version == null) {
            await into(appVersions)
                .insert(AppVersionsCompanion.insert(version: currentVersion));
          } else {
            await update(appVersions)
                .replace(AppVersion(id: version.id, version: currentVersion));
          }
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
        if (from < 4) {
          await m.addColumn(saldos, saldos.createdAt);
        }
        if (from < 5) {
          await m.addColumn(categories, categories.createdAt);
        }
        if (from < 6) {
          await m.createTable($BudgetinVariablesTable(attachedDatabase));
        }
        if (from < 7) {}
        if (from < 8) {
          await m.createTable($AppVersionsTable(attachedDatabase));
        }
        if (from < 9) {
          await m.createTable($UserTrackersTable(attachedDatabase));
          await into(userTrackers)
              .insert(UserTrackersCompanion.insert(uuid: UuidV4().generate()));
        }
      },
    );
  }

  Future<UserTracker?> getUser() async {
    return await select(userTrackers).getSingleOrNull();
  }

  Future<UserTracker> storeUser(UserTrackersCompanion user) async {
    return await into(userTrackers).insertReturning(user);
  }

  Future<void> clearAllTables() async {
    final tables = allTables.map((t) => delete(t).go());
    await Future.wait(tables);
  }

  Future<int> getTotalAmountForMonth(DateTime date) async {
    final query = select(transactions)
      ..where((t) =>
          t.transaction_date.year.equals(date.year) &
          t.transaction_date.month.equals(date.month));

    final rows = await query.get();
    print(rows);
    final totalAmount = rows.fold<int>(0, (total, row) => total + row.amount);
    return totalAmount;
  }

  Future<double> prsentaseExpense(DateTime selectedDate) async {
    final totalAmount = await getTotalAmountForMonth(selectedDate);
    final saldo = await (select(saldos)
          ..where((tbl) =>
              tbl.createdAt.month.equals(selectedDate.month) &
              tbl.createdAt.year.equals(selectedDate.year)))
        .getSingleOrNull();

    if (saldo != null) {
      final remainingSaldo = totalAmount / saldo.saldo.toDouble();
      return remainingSaldo * 100;
    } else {
      print("No saldo entries found.");
      return 0; // Handle the case when there is no saldo entry as needed
    }
  }

  Future<int> remainingMoney() async {
    String? val = await getBudgetinVariable('monthNow');
    final totalAmount = await getTotalAmountForMonth(DateTime.parse(val!));
    try {
      final date = DateTime.parse(val);
      final query = select(saldos)
        ..where((tbl) =>
            tbl.createdAt.year.equals(date.year) &
            tbl.createdAt.month.equals(date.month))
        ..getSingleOrNull();
      Saldo saldo = await query.getSingle();

      final remainingSaldo = saldo.saldo - totalAmount;
      return remainingSaldo;
    } catch (e) {
      return 0;
    }
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

  Future<List<Category>> getAllCategoryByMonthYear(
      int month, String year) async {
    final categories = await (select(this.categories)
          ..where((tbl) =>
              tbl.createdAt.month.equals(month) &
              tbl.createdAt.year.equals(int.parse(year))))
        .get();
    return categories;
  }

  Future<bool> updateCategory(CategoriesCompanion entry) async {
    return await update(categories).replace(entry);
  }

  Future<bool> deleteCategory(int id) async {
    try {
      await (delete(categories)..where((tbl) => tbl.id.equals(id)))
          .go()
          .then((value) {
        (delete(transactions)..where((tbl) => tbl.category_id.equals(id))).go();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<TransactionWithCategory>> getAllTransactionWithCategory(
      int month) {
    final int firstDay = DateTime(DateTime.now().year, month + 1, 0).day;
    final query = (select(transactions)
          ..where((tbl) => tbl.transaction_date.month.equals(month)
              // tbl.transaction_date.day.isBetweenValues(0, firstDay)
              )
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.transaction_date, mode: OrderingMode.asc)
          ]))
        .join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id))
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
            row.readTable(transactions), row.readTable(categories));
      }).toList();
    });
  }

  Stream<List<TransactionWithCategory>> searchTransactionRepo(String keyword) {
    final query = (select(transactions)
          ..where((tbl) => tbl.name.like("%$keyword%")))
        .join([
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
    DateTime now = DateTime.now();
    final datas = await (select(transactions)
          ..where((tbl) =>
              tbl.category_id.equals(categoryId) &
              tbl.transaction_date.month.equals(now.month) &
              tbl.transaction_date.year.equals(now.year)))
        .get();
    int totalAmount = 0;

    for (final data in datas) {
      totalAmount += data.amount;
    }

    return totalAmount;
  }

  Stream<List<CategoryTotal>> sumExpenseByCategory(int limit) {
    DateTime now = DateTime.now();
    final categoriesResultStream = limit != 0
        ? (select(categories)
              ..where(
                (tbl) =>
                    tbl.createdAt.month.equals(now.month) &
                    tbl.createdAt.year.equals(now.year),
              )
              ..limit(limit))
            .watch()
        : (select(categories)
              ..where(
                (tbl) =>
                    tbl.createdAt.month.equals(now.month) &
                    tbl.createdAt.year.equals(now.year),
              ))
            .watch();

    return categoriesResultStream.asyncMap((categoriesResult) async {
      final List<CategoryTotal> categoryTotals = [];

      for (final category in categoriesResult) {
        final totalAmount = await _calculateTotalAmountForCategory(category.id);
        categoryTotals.add(CategoryTotal(category, totalAmount));
      }

      return categoryTotals;
    });
  }

  Stream<List<CategoryTotal>> sumExpenseByCategorySearch(String keyword) {
    // print(keyword);
    DateTime now = DateTime.now();
    final categoriesResultStream = (select(categories)
          ..where(
            (tbl) =>
                tbl.createdAt.month.equals(now.month) &
                tbl.createdAt.year.equals(now.year) &
                tbl.name.like('%$keyword%'),
          ))
        .watch();

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
    final rowsQuery = select(categories)
      ..where((tbl) =>
          tbl.createdAt.month.equals(DateTime.now().month) &
          tbl.createdAt.year.equals(DateTime.now().year))
      ..get();
    final rows = await rowsQuery.get();

    total =
        rows.map((e) => e.total).fold(0, (acc, value) => acc + (value ?? 0));
    return total;
  }

  Stream<int> watchUsedSaldo() async* {
    DateTime now = DateTime.now();
    int sal = await getFirstSaldo().then((value) => value!.saldo);
    final transactionQuery = select(transactions)
      ..where((tbl) =>
          tbl.transaction_date.month.equals(now.month) &
          tbl.transaction_date.year.equals(now.year));
    final datas = await transactionQuery.get();
    // final datas = await allTransactions();
    int totalExpense = 0;

    for (final data in datas) {
      totalExpense += data.amount;
    }
    yield sal - totalExpense;
  }

  Stream<Saldo> watchSaldoMonthNow() {
    DateTime now = DateTime.now();
    return (select(saldos)
          ..where((tbl) =>
              tbl.createdAt.month.equals(now.month) &
              tbl.createdAt.year.equals(now.year)))
        .watchSingle();
  }

  Stream<int> watchRemainSaldo() async* {
    int total = 0;
    final rows = await select(categories).get();
    total =
        rows.map((e) => e.total).fold(0, (acc, value) => acc + (value ?? 0));
    int sal = await getFirstSaldo().then((value) => value!.saldo);
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

  Future<List<bool>> isSaldoNotCretedYet() async {
    List<bool> res = [false, false];
    final query = select(saldos)..limit(1);
    final result = await query.get();
    final a = await getBudgetinVariable('monthNow');
    int now = DateTime.now().month;

    if (result.isNotEmpty) {
      if (a != null && DateTime.parse(a).month != now) {
        res = [false, true];
        return res;
      }
      return res;
    } else {
      if (a != null && DateTime.parse(a).month != now) {
        res = [true, true];
        return res;
      }
      res = [true, false];
      return res;
    }
  }

  Future<Saldo?> getFirstSaldo() async {
    final now = DateTime.now();
    final query = select(saldos)
      ..where((tbl) =>
          tbl.createdAt.year.equals(now.year) &
          tbl.createdAt.month.equals(now.month))
      ..getSingleOrNull();
    final result = await query.get();

    return result.isNotEmpty
        ? result.first
        : Saldo(id: 1, saldo: 0, createdAt: DateTime.now());
  }

  Stream<Saldo> watchFirstSaldo() {
    return (select(saldos)
          ..orderBy([
            // (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .watchSingle();
  }

  Future<int> createOrUpdateSaldo(int saldo) async {
    final now = DateTime.now();
    final existingSaldo = await (select(saldos)
          ..where((tbl) =>
              tbl.createdAt.month.equals(now.month) &
              tbl.createdAt.year.equals(now.year)))
        .getSingleOrNull();

    if (existingSaldo != null) {
      return (update(saldos)..where((tbl) => tbl.id.equals(existingSaldo.id)))
          .write(SaldosCompanion(saldo: Value(saldo)));
    } else {
      return into(saldos).insert(SaldosCompanion.insert(saldo: saldo));
    }
  }

  Future<bool> isSaldoLessThanAllocation(int saldo) async {
    int allocation = await sumUsedSaldo();
    if (saldo < allocation) {
      return false;
    } else {
      return true;
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

  Stream<int> totalExpenseMonth() async* {
    // Mendapatkan semua transaksi
    final datas = await allTransactions();

    // Mendapatkan tanggal awal dan akhir bulan ini
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth =
        DateTime(now.year, now.month + 1, 0); // Hari terakhir bulan ini

    // Menghitung total pengeluaran bulan ini
    int totalExpense = 0;
    for (final data in datas) {
      if (data.transaction_date
              .isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
          data.transaction_date
              .isBefore(endOfMonth.add(const Duration(days: 1)))) {
        totalExpense += data.amount;
        yield totalExpense;
      }
    }
  }

  Stream<Map<int, Map<dynamic, dynamic>>>
      sumTransactionsByMonthAndCategory() async* {
    final transactionsData = select(this.transactions)
      ..where((tbl) => tbl.transaction_date.year.equals(DateTime.now().year))
      ..get();
    final transactions = await transactionsData.get();
    final saldo = await getFirstSaldo().then((value) => value!.saldo);
    final Map<int, Map<dynamic, dynamic>> sums = {
      1: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      2: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      3: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      4: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      5: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      6: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      7: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      8: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      9: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      10: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
      11: {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}},
    };
    double sum = 0;

    for (var transaction in transactions) {
      final kategori = await getCategory(transaction.category_id);

      final categoryName = kategori.name;
      final categoryId = transaction.category_id;
      final transactionDate = transaction.transaction_date;
      final month = DateTime(transactionDate.year, transactionDate.month);
      final amount = transaction.amount ?? 0;
      if (!sums.containsKey(transactionDate.month - 1)) {
        sums.update(
            transactionDate.month - 1,
            (value) =>
                {"total": 0, "persen": 0.5, "saldo": saldo, "daftar": {}});
      }
      sums[transactionDate.month - 1]!["total"] =
          sums[transactionDate.month - 1]!["total"] + amount;
      sums[transactionDate.month - 1]!["persen"] = double.parse(
              (sums[transactionDate.month - 1]!["total"] / saldo).toString())
          .toStringAsFixed(3);

      final monthSums = sums[transactionDate.month - 1]!["daftar"];

      if (monthSums.containsKey(categoryId)) {
        monthSums[categoryId]["amount"] =
            (monthSums[categoryId]["amount"]! + amount);
      } else {
        monthSums[categoryId] = {"name": categoryName, "amount": amount};
      }

      yield Map.from(sums);
    }
  }

  Stream<List<StatisticData>> sumTransactionsByMonthAndYear(int year) async* {
    List<StatisticData> statistic = [];
    Random random = Random();

    for (int i = 1; i <= 12; i++) {
      int transactionMonth = 0;
      int saldoMonth = 0;
      var transactionsQuery = select(transactions)
        ..where((tbl) =>
            tbl.transaction_date.month.equals(i) &
            tbl.transaction_date.year.equals(year));

      var transactionResult = await transactionsQuery.get();
      transactionResult.forEach((row) {
        transactionMonth += row.amount;
      });
      var saldoQuery = select(saldos)
        ..where((tbl) =>
            tbl.createdAt.month.equals(i) & tbl.createdAt.year.equals(year));

      var saldoResult = await saldoQuery.getSingleOrNull();
      if (saldoResult != null) {
        saldoMonth = saldoResult.saldo;
      }

      double persen = saldoMonth != 0 ? transactionMonth / saldoMonth : 0.0;

      var categoriesQuery = select(categories)
        ..where((tbl) =>
            tbl.createdAt.month.equals(i) & tbl.createdAt.year.equals(year));
      var categoriesResult = await categoriesQuery.get();
      List<StatisticCategory> categoriesData = [];
      int totalTransactionInCategory = 0;
      for (var category in categoriesResult) {
        totalTransactionInCategory = 0;
        var categoryTransactionQuery = select(transactions)
          ..where((tbl) =>
              tbl.transaction_date.month.equals(i) &
              tbl.transaction_date.year.equals(year) &
              tbl.category_id.equals(category.id));
        var categoryTransactionResult = await categoryTransactionQuery.get();
        categoryTransactionResult.forEach((row) {
          totalTransactionInCategory += row.amount;
        });
        categoriesData.add(StatisticCategory(
            color: RandomColor.generate(),
            name: category.name,
            persen: saldoMonth != 0 && totalTransactionInCategory != 0
                ? totalTransactionInCategory / saldoMonth * 100
                : 0.0));
      }

      categoriesData.add(StatisticCategory(
          color: 0xFFD1D1D1,
          name: "Sisa",
          persen: saldoMonth != 0
              ? (saldoMonth - transactionMonth) / saldoMonth * 100
              : 0.0));

      statistic.add(StatisticData(persen: persen * 100, data: categoriesData));
    }
    // print(statistic[4].data![.first].persen);
    yield statistic;
  }

  Future<List<double>> getTransactionsByMonth() async {
    final transactions = select(this.transactions)
      ..where((tbl) => tbl.transaction_date.year.equals(DateTime.now().year))
      ..get();

    final saldo = await getFirstSaldo().then((value) => value!.saldo);
    final transaksi = await transactions.get();
    List<double> data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<double> persen = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    double amount = 0;
    for (var transaction in transaksi) {
      data[transaction.transaction_date.month - 1] =
          transaction.amount + data[transaction.transaction_date.month - 1];
      persen[transaction.transaction_date.month - 1] =
          data[transaction.transaction_date.month - 1] / saldo +
              persen[transaction.transaction_date.month - 1];
    }

    return data;
  }

  Future<String?> getBudgetinVariable(String key) async {
    final existingVarQuery = select(budgetinVariables)
      ..where((tbl) => tbl.name.equals(key))
      ..getSingleOrNull();

    final existingVar = await existingVarQuery.getSingleOrNull();

    if (existingVar != null) {
      return existingVar.value;
    } else {
      return null;
    }
  }

  Future<bool> copyPreviousCategoryAndSaldo() async {
    // DateTime date = DateTime.now();
    String? val = await getBudgetinVariable('monthNow');
    try {
      final date = DateTime.parse(val!);
      final query = select(saldos)
        ..where((tbl) =>
            tbl.createdAt.year.equals(date.year) &
            tbl.createdAt.month.equals(date.month))
        ..getSingleOrNull();
      Saldo saldo = await query.getSingle();

      createOrUpdateSaldo(saldo.saldo);
      final queryCategories = select(this.categories)
        ..where((tbl) =>
            tbl.createdAt.month.equals(date.month) &
            tbl.createdAt.year.equals(date.year))
        ..get();
      final categories = await queryCategories.get();
      for (var category in categories) {
        into(this.categories).insert(CategoriesCompanion(
            name: Value(category.name),
            icon: Value(category.icon),
            total: Value(category.total)));
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> insertBudgetinVariable(String key, String value) async {
    final existingVar = await (select(budgetinVariables)
          ..where((tbl) => tbl.name.equals(key)))
        .getSingleOrNull();

    if (existingVar != null) {
      return (update(budgetinVariables)
            ..where((tbl) => tbl.id.equals(existingVar.id)))
          .write(BudgetinVariablesCompanion(
              name: Value(key), value: Value(value)));
    } else {
      return into(budgetinVariables).insert(
          BudgetinVariablesCompanion(name: Value(key), value: Value(value)));
    }
  }

  Stream<List<Category>> getAllCategoryByMonthAndYear() {
    DateTime now = DateTime.now();
    return (select(categories)
          ..where((tbl) =>
              tbl.createdAt.month.equals(now.month) &
              tbl.createdAt.year.equals(now.year)))
        .watch();
  }

  Stream<List<Category>> getAllCategoryByMonthAndYearSearch(String keyword) {
    DateTime now = DateTime.now();
    return (select(categories)
          ..where((tbl) =>
              tbl.createdAt.month.equals(now.month) &
              tbl.createdAt.year.equals(now.year) &
              tbl.name.like(keyword)))
        .watch();
  }

  Stream<TransactionInsert> streamCategoryById(int id, bool edit,
      {int temp = 0}) async* {
    Category category = await getCategory(id);
    int maks = await sumExpenseCategory(id);

    yield TransactionInsert(
      category: category,
      total: edit ? (category.total - maks + temp) : category.total - maks,
    );
  }

  Future<SaldoData> getDataSaldo() async {
    Saldo? saldo = await getFirstSaldo();
    int alokasi = await sumUsedSaldo();

    return SaldoData(saldo: saldo!.saldo, teralokasi: alokasi);
  }

  Future<List<Category>> searchCategoryRepo(String keyword) async {
    return await (select(categories)
          ..where((tbl) =>
              tbl.name.like("%$keyword%") &
              tbl.createdAt.month.equals(DateTime.now().month) &
              tbl.createdAt.year.equals(DateTime.now().year)))
        .get();
  }

  Future<List<TransactionWithCategory>> getTransactionInRange(
      DateTime start, DateTime end) async {
    DateTime adjustedStart =
        DateTime(start.year, start.month, start.day, 0, 0, 0);

    DateTime adjustedEnd = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final query = await (select(transactions)
          ..where((tbl) =>
              tbl.transaction_date.isBetweenValues(adjustedStart, adjustedEnd)))
        .join([
      innerJoin(categories, categories.id.equalsExp(transactions.category_id))
    ]).get();

    return query.map((e) {
      return TransactionWithCategory(
          e.readTable(transactions), e.readTable(categories));
    }).toList();
  }

  Stream<DetailKategori> getDetailCategory(int id) {
    final categoryQuery = select(categories).join([
      leftOuterJoin(
          transactions, transactions.category_id.equalsExp(categories.id))
    ])
      ..where(categories.id.equals(id));

    return categoryQuery.watch().map((rows) {
      if (rows.isEmpty) {
        return DetailKategori(
          category: Category(
            createdAt: DateTime.now(),
            icon: 'assets/icons/Lainnya.svg',
            id: id,
            name: '',
            total: 0,
          ),
          totalAmount: 0,
          remainAmount: 0,
        );
      }

      final category = rows.map((row) => row.readTable(categories)).first;

      final transactionList = rows
          .map((row) => row.readTableOrNull(transactions))
          .where((transaction) => transaction != null)
          .toList();

      final totalAmount = transactionList.fold(
          0, (sum, transaction) => sum + (transaction?.amount ?? 0));

      final remainAmount = category.total - totalAmount;

      return DetailKategori(
        category: category,
        totalAmount: totalAmount,
        remainAmount: remainAmount,
      );
    });
  }

  Future<int> getTotalExpenseByCategory(int id) async {
    final transactionQuery = select(this.transactions)
      ..where(
        (tbl) => tbl.category_id.equals(id),
      );
    final transactions = await transactionQuery.get();
    int totalAmount = 0;
    for (var transaction in transactions) {
      totalAmount += transaction.amount;
    }

    return totalAmount;
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
