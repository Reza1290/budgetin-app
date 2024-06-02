import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/reusable/new_calender.dart';
import 'package:flutter/material.dart';

typedef void ListCallback(List<DateTime> tanggal);

class RangeDate extends StatefulWidget {
  final ListCallback? setTanggal;
  const RangeDate({super.key, this.setTanggal});
  @override
  State<RangeDate> createState() => _RangeDateState();
}

class _RangeDateState extends State<RangeDate> {
  late DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDate2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Dari', style: TextStyle(color: BudgetinColors.hitamPutih50)),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          child:
              buildCalendarDialogButton(context, _selectedDate, "", (newDate) {
            setState(() {
              _selectedDate = newDate;
            });
            widget.setTanggal!([_selectedDate, _selectedDate2]);
          }, isTransaksi: false),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Sampai', style: TextStyle(color: BudgetinColors.hitamPutih50)),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          child:
              buildCalendarDialogButton(context, _selectedDate2, "", (newDate) {
            setState(() {
              _selectedDate2 = newDate;
            });
            widget.setTanggal!([_selectedDate, _selectedDate2]);
          }, isTransaksi: false),
        )
      ],
    );
  }
}
