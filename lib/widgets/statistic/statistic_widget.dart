import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/statistic/statistic_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticContentModel {
  String name;
  double amount;
  StatisticContentModel({required this.name, required this.amount});
}

class StatisticWidget extends StatefulWidget {
  final String bulan;
  final Map<dynamic, dynamic> content;
  const StatisticWidget(
      {super.key, required this.bulan, required this.content});

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());
    return Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.bulan,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                value: double.parse(widget.content["persen"]),

                // backgroundColor: Colors.black.withOpacity(0.04),
                color: kuningWarn,
                minHeight: 16,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          trailing: _expanded
              ? const Icon(Icons.arrow_drop_up)
              : const Icon(Icons.arrow_drop_down),
        ),
        if (_expanded)
          Column(
            children: widget.content["daftar"].entries
                .map((e) {
                  return StatisticContent(
                    prosentase: (NumberFormat.percentPattern('id').format(
                            double.parse(
                                (e.value["amount"] / widget.content["saldo"])
                                    .toStringAsFixed(3))))
                        .toString(),
                    content: e.value["name"].toString(),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
      ],
    );
  }
}
