import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Filter extends StatelessWidget {
  final int selectedMonth;
  final ValueChanged<int> onMonthSelected;

  const Filter({
    super.key,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize date formatting
    initializeDateFormatting('id', null);

    final months = List.generate(12, (index) {
      DateTime date = DateTime(0, index + 1);
      return DateFormat.MMMM('id').format(date);
    });

    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            onMonthSelected(index + 1); 
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: selectedMonth == index + 1 ? Colors.blue : null,
              border: selectedMonth == index + 1
                  ? null
                  : Border.all(
                      color: const Color.fromRGBO(209, 209, 209, 1),
                      width: 1,
                    ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _buildText(
                months[index],
                12,
                selectedMonth == index + 1 ? FontWeight.bold : FontWeight.w600,
                selectedMonth == index + 1
                    ? Colors.white
                    : const Color.fromRGBO(209, 209, 209, 1),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: months.length,
      ),
    );
  }

  Widget _buildText(
    String text,
    double size,
    FontWeight weight,
    Color color,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
