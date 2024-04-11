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
        title: const Text("FAQ"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: months.length,
              itemBuilder: (context, index) {
                final month = months[index];
                return StatisticWidget(bulan: month);
              }),
        ),
      ),
    );
  }
}
