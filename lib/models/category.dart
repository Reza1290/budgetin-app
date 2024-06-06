import 'package:drift/drift.dart';

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 128)();
  TextColumn get icon =>
      text().withDefault(Constant('assets/icons/Lainnya.svg'))();
  IntColumn get total => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
