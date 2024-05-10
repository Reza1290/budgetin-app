import 'package:budgetin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticBar extends StatefulWidget {
  const StatisticBar({super.key});

  @override
  State<StatisticBar> createState() => _StatisticBarState();
}

class _StatisticBarState extends State<StatisticBar> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;

  List<double> dataBulanan = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  Future<List<double>> getDataBulanan() async {
    List<double> data = await db!.getTransactionsByMonth();

    setState(() {
      dataBulanan = data;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getDataBulanan();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BudgetinColors.biru20, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Grafik Pengeluaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: AspectRatio(
                aspectRatio: 2,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: BarChart(
                            mainBarData(),
                            swapAnimationDuration: animDuration,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 20,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? Colors.amber : Color(0xFFA4CEFF),
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<double> data = dataBulanan;

    List<int> indices = List.generate(12, (index) => index);

    List<BarChartGroupData> chartData = indices.map((index) {
      double value = data[index];
      return makeGroupData(index, value, isTouched: index == touchedIndex);
    }).toList();

    return chartData;
  }

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.center,
      groupsSpace: 12,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'January';
                break;
              case 1:
                weekDay = 'February';
                break;
              case 2:
                weekDay = 'March';
                break;
              case 3:
                weekDay = 'April';
                break;
              case 4:
                weekDay = 'May';
                break;
              case 5:
                weekDay = 'June';
                break;
              case 6:
                weekDay = 'July';
                break;
              case 7:
                weekDay = 'August';
                break;
              case 8:
                weekDay = 'September';
                break;
              case 9:
                weekDay = 'October';
                break;
              case 10:
                weekDay = 'November';
                break;
              case 11:
                weekDay = 'December';
                break;

              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: TextCurrencyFormat.format((rod.toY).toString()),
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: getTitles,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitles,
            // interval: interval,
            reservedSize: 42,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: FlGridData(
        show: true,
        checkToShowHorizontalLine: (value) => value % 5 == 0,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Color(0xFFD1D1D1),
          strokeWidth: 1,
          dashArray: [10],
        ),
        drawVerticalLine: false,
      ),
      borderData: FlBorderData(
          border: Border(
        top: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide.none,
        bottom: BorderSide.none,
      )),
      barGroups: showingGroups(),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(fontSize: 8, color: BudgetinColors.hitamPutih60);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
      case 1:
        text = 'Feb';
      case 2:
        text = 'Mar';
      case 3:
        text = 'Apr';
      case 4:
        text = 'Mei';
      case 5:
        text = 'Juni';
      case 6:
        text = 'Jul';
      case 7:
        text = 'Aug';
      case 8:
        text = 'Sep';
      case 9:
        text = 'Okt';
      case 10:
        text = 'Nov';
      case 11:
        text = 'Des';
      default:
        return const Text('');
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    var style = TextStyle(fontSize: 10, color: BudgetinColors.hitamPutih60);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }
}
