import 'package:budgetin/main.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/widgets/statistic/statistic_widget.dart';
import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  StatisticScreen({super.key});

  final List<String> months = ['Januari', 'Februari', 'Maret', 'April', 'dll'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: StreamBuilder<List<MapEntry<DateTime, Map<String, int>>>>(
            stream: db!.sumTransactionsByMonthAndCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('Statistik Belum Tersedia');
              } else {
                final data = snapshot.data!;
                debugPrint(data.toString());
                return Text('');
              }
            },
          ),
        ),
      ),
    );
  }
}
