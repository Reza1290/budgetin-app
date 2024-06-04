import 'package:drift/drift.dart';

@DataClassName('UserTracker')
class UserTrackers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().withLength(max: 128)();
  TextColumn get name => text().withLength(max: 128).nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
