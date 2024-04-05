import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Ganti warna utama sesuai keinginan
            ),
            dialogBackgroundColor: Colors
                .white, // Ganti warna latar belakang dialog sesuai keinginan
            // atur kelengkungan dialog sesuai keinginan
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 6,
            child: Flexible(
              child: SizedBox(
                height: 40, // Tinggi TextField
                child: TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: hitamPutih40),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        color: hitamPutih40,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const SizedBox(
                      width: 12,
                      child: Icon(Icons.search, color: hitamPutih80),
                    ),
                    contentPadding: EdgeInsets.zero, // Hilangkan padding
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 0,
          child: IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: const Icon(
              Icons
                  .calendar_month_rounded, // Mengubah dari 'Icons.calendar_month_rounded' menjadi 'Icons.calendar_today_rounded'
              size: 30,
              color: Color.fromRGBO(61, 61, 61, 1),
            ),
            highlightColor: Colors
                .transparent, // Mengatur warna highlight menjadi transparan
            splashColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
