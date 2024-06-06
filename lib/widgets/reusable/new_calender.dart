import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

// String _getValueText(
//   CalendarDatePicker2Type datePickerType,
//   DateTime value,
// ) {
//   var date = DateUtils.dateOnly(value); // Menghilangkan waktu dari DateTime
//   var valueText = date
//       .toString()
//       .replaceAll('00:00:00.000', ''); // Menghilangkan informasi waktu
//   return valueText;
// }

Widget buildCalendarDialogButton(BuildContext context, DateTime selectedDate,
    String label, Function(DateTime) onDateSelected,
    {double? height = 45, bool? isTransaksi = true}) {
  return Container(
    height: height,
    child: GestureDetector(
      onTap: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: context,
          config: _buildCalendarConfig(context, isTransaksi: isTransaksi),
          dialogSize: const Size(325, 400),
          borderRadius: BorderRadius.circular(15),
          value: [selectedDate],
          dialogBackgroundColor: Colors.white,
        );
        // onDateSelected(selectedDate);
        onDateSelected(values?[0] ?? selectedDate);
        print('tanggal' + values.toString());
        // print(values);
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            suffixIcon: const Icon(Icons.calendar_month),
            hintText:
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ",
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          readOnly: true,
        ),
      ),
    ),
  );
}

CalendarDatePicker2WithActionButtonsConfig _buildCalendarConfig(
    BuildContext context,
    {bool? isTransaksi = false}) {
  const dayTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700);

  return CalendarDatePicker2WithActionButtonsConfig(
    calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
    dayTextStyle: dayTextStyle,
    calendarType: CalendarDatePicker2Type.single,
    selectedDayHighlightColor: Color(0xFF1D77FF),
    closeDialogOnCancelTapped: true,
    firstDayOfWeek: 1,
    selectableDayPredicate: isTransaksi != null && isTransaksi
        ? (day) =>
            day.month == DateTime.now().month &&
            day.year == DateTime.now().year &&
            day.isBefore(DateTime.now())
        : (day) => true,
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
    dayBuilder: ({
      required date,
      textStyle,
      decoration,
      isSelected,
      isDisabled,
      isToday,
    }) {
      Widget? dayWidget;
      if (date.day % 3 == 0 && date.day % 9 != 0) {
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  MaterialLocalizations.of(context).formatDecimal(date.day),
                  style: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.5),
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          isSelected == true ? Colors.white : Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return dayWidget;
    },
    yearBuilder: ({
      required year,
      decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
    }) {
      return Center(
        child: Container(
          decoration: decoration,
          height: 36,
          width: 72,
          child: Center(
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year.toString(),
                    style: textStyle,
                  ),
                  if (isCurrentYear == true)
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
