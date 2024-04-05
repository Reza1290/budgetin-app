import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key});

  final List<Color> availableColors = const <Color>[
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.pink,
  ];

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;

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
            Text(
              "Grafik Pengeluaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFA4CEFF), width: 3),
              ),
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
            SizedBox(
              height: 20,
            ),
            Text("Diagram Kategori",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFA4CEFF), width: 3),
                ))
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 10,
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

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 11, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 10, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 13, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 20, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 30, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 35, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, 35, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, 27, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, 18, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, 26, isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, 30, isTouched: i == touchedIndex);
          default:
            throw Error();
        }
      });

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
                  text: (rod.toY).toString(),
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
            interval: 5,
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
    const style = TextStyle(fontSize: 8, color: hitamPutih60);
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
    const style = TextStyle(fontSize: 10, color: hitamPutih60);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }
}
