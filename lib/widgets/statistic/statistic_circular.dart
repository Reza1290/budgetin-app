import 'package:budgetin/widgets/statistic/chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticCircular extends StatefulWidget {
  const StatisticCircular({super.key});

  @override
  State<StatisticCircular> createState() => _StatisticCircularState();
}

class _StatisticCircularState extends State<StatisticCircular> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BudgetinPieChart(
        strokeWidth: 32,
        data: const [
          PieChartData(Colors.purple, 60),
          PieChartData(Colors.blue, 25),
          PieChartData(Colors.orange, 15),
        ],
        radius: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '95%',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text('Total Used'),
          ],
        ),
      ),
    );
  }
}

class PieChartData {
  const PieChartData(this.color, this.percent);

  final Color color;
  final double percent;
}
