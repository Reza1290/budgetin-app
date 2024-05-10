import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/statistic/statistic_bar.dart';
import 'package:budgetin/widgets/statistic/statistic_circular.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistik',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticBar(),
            SizedBox(
              height: 20,
            ),
            Text("Diagram Kategori",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: BudgetinColors.biru20, width: 2),
              ),
              child: StatisticCircular(),
            )
          ],
        ),
      ),
    );
  }
}
