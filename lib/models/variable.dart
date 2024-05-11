import 'package:drift/drift.dart';

@DataClassName('BudgetinVariable')
class BudgetinVariables extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 128)();
  TextColumn get value => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
