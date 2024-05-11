import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/reusable/newCalender.dart';
import 'package:flutter/material.dart';

class RangeDate extends StatefulWidget {
  const RangeDate({super.key});

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
               
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: buildCalendarDialogButton(context, _selectedDate, "",
                      (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(child: Text('-- Hingga --',style: TextStyle(color: BudgetinColors.hitamPutih50)),),
                SizedBox(
                  height: 5,
                ),
                
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: buildCalendarDialogButton(context, _selectedDate2, "",
                      (newDate) {
                    setState(() {
                      _selectedDate2 = newDate;
                    });
                  }),
                )
              ],
            );
  }
}