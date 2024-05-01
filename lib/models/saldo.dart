import 'package:drift/drift.dart';

@DataClassName('Saldo')
class Saldos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saldo => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}