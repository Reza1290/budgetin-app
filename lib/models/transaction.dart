import 'package:drift/drift.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 250)();
  TextColumn get description => text().withLength(max: 250)();
  IntColumn get category_id => integer()();
  IntColumn get amount => integer()();
  DateTimeColumn get transaction_date => dateTime()();
}