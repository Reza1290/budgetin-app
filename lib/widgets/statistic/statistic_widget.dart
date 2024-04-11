import 'package:budgetin/widgets/statistic/statistic_content.dart';
import 'package:flutter/material.dart';

class Penggunaan {
  String name;
  int total;

  Penggunaan({required this.name, required this.total});
}

class StatisticWidget extends StatefulWidget {
  final String bulan;
  final List<Penggunaan> content;
  const StatisticWidget({super.key, required this.bulan, required this.content});

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
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
                value: 0.5,
                backgroundColor: Colors.black.withOpacity(0.04),
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
            children: [
              const StatisticContent(
                content: "Makananan",
                prosentase: "50%",
              ),
              const StatisticContent(
                content: "Kesehatan",
                prosentase: "10%",
              ),
              const StatisticContent(
                content: "Urip",
                prosentase: "80%",
              ),
            ],
          ),
      ],
    );
  }
}
