import 'package:budgetin/models/database.dart';

class TransactionInsert {
  Category category;
  int total;

  TransactionInsert({required this.category, required this.total});
}
