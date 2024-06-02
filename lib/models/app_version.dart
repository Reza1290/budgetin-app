import 'package:drift/drift.dart';

@DataClassName('AppVersion')
class AppVersions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get version => text()();
}
