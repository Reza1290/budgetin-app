import 'package:budgetin/models/statistic_category.dart';

class StatisticData {
  double persen;
  List<StatisticCategory>? data;

  StatisticData({
    required this.persen,
    this.data,
  });
}
