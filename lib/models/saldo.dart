import 'package:drift/drift.dart';

class Saldos extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saldo => integer()();
}