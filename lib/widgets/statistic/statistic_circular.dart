import 'package:budgetin/main.dart';
import 'package:budgetin/models/statistic_data.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/statistic/chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticCircular extends StatefulWidget {
  final int bulan;
  const StatisticCircular({super.key, required this.bulan});

  @override
  State<StatisticCircular> createState() => _StatisticCircularState();
}

class _StatisticCircularState extends State<StatisticCircular> {
  @override
  Widget build(BuildContext context) {
    // print(widget.bulan);

    return Center(
      child: StreamBuilder<List<StatisticData>>(
          stream: db!.sumTransactionsByMonthAndYear(DateTime.now().year),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      Image.asset('assets/images/handling/white_loading.gif'),
                ),
              ); // or any other loading widget
            } else if (snapshot.hasError) {
              return Text('');
            } else if (snapshot.hasData &&
                snapshot.data!.isNotEmpty &&
                snapshot.data != null) {
              double total = snapshot.data![widget.bulan].persen;
              // print(total);
              List<StatisticData>? dataPerCategory =
                  List.from(snapshot.data ?? []);
              List<StatisticData>? dataTotal = List.from(snapshot.data ?? []);

              if (dataTotal.isNotEmpty &&
                  dataTotal[widget.bulan].data != null &&
                  dataTotal[widget.bulan].data!.isNotEmpty) {
                if (dataTotal[widget.bulan].data!.last.persen < 5) {
                  dataTotal[widget.bulan].data!.removeLast();
                }
              }

              List<PieChartData> pieChartData = dataTotal[widget.bulan]
                  .data!
                  .where((element) => element.persen >= 5)
                  .map((e) => PieChartData(Color(e.color), e.persen))
                  .toList();

              return Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: BudgetinPieChart(
                      strokeWidth: 32,
                      data: total > 95
                          ? [PieChartData(BudgetinColors.merah50, total)]
                          : pieChartData,
                      radius: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${total.toStringAsFixed(1)}%", // Display the total persen value
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                          Text('Terpakai'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: GridView.count(
                        childAspectRatio: 2,
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            dataPerCategory[widget.bulan].data!.length,
                            (index) {
                          return ListTile(
                            leading: Container(
                              child: BudgetinPieChart(
                                data: [
                                  if (dataPerCategory[widget.bulan]
                                          .data![index]
                                          .persen >
                                      0)
                                    PieChartData(
                                      Color(
                                        dataPerCategory[widget.bulan]
                                                    .data![index]
                                                    .name
                                                    .toLowerCase() ==
                                                'sisa'
                                            ? 0xFFFF00FF
                                            : dataPerCategory[widget.bulan]
                                                .data![index]
                                                .color,
                                      ),
                                      dataPerCategory[widget.bulan]
                                          .data![index]
                                          .persen,
                                    ),
                                  if (dataPerCategory[widget.bulan]
                                          .data![index]
                                          .persen <
                                      95)
                                    PieChartData(
                                        Color(0xFFD1D1D1),
                                        (dataPerCategory[widget.bulan]
                                                    .data![index]
                                                    .persen >
                                                0)
                                            ? (100 -
                                                dataPerCategory[widget.bulan]
                                                    .data![index]
                                                    .persen)
                                            : 100),
                                ],
                                radius: 24,
                                child: Text(
                                    '${dataPerCategory[widget.bulan].data![index].persen.toStringAsFixed(1)}%'),
                              ),
                            ),
                            title: Text(
                              dataPerCategory[widget.bulan].data![index].name,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // If there's no data, display a message indicating it
              return Text('No data available.');
            }
          }),
    );
  }
}

class PieChartData {
  const PieChartData(this.color, this.percent);

  final Color color;
  final double percent;
}
