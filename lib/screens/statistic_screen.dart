import 'package:budgetin/main.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/statistic/statistic_widget.dart';
import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BudgetinColors.hitamPutih10,
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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<Map<DateTime, Map<dynamic, dynamic>>>(
            stream: db!.sumTransactionsByMonthAndCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text('Data Belum Tersedia'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Data Belum Tersedia'));
              } else {
                final data = snapshot.data!;

                return Column(
                  children: data.entries.map((e) {
                    return StatisticWidget(
                      bulan:
                          HumanReadableDateFormatter.dateMonthFormatter(e.key),
                      content: e.value,
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
