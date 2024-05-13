import 'package:budgetin/models/database.dart';

class DetailKategori {
  Category category;
  int totalAmount;
  int remainAmount;
  DetailKategori({required this.category, required this.totalAmount, required this.remainAmount});
}
