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
  int _selectedIndex = DateTime.now().month - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        leadingWidth: 100,
        title: const Text("Statistik"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticBar(
                  bulan: _selectedIndex,
                  callback: _setBulan,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Diagram Kategori",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: BudgetinColors.biru20, width: 2),
                  ),
                  child: StatisticCircular(
                    bulan: _selectedIndex,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setBulan(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
