import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key, required this.controller, this.focusNode});

  final TextEditingController controller;
  final FocusNode? focusNode;

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
          flex: 5,
          child: SizedBox(
            height: 50, // Tinggi TextField
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: putih40),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: const BorderSide(color: biruPrimary, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(
                    color: putih40, fontSize: 12, fontWeight: FontWeight.w600),
                suffixIcon: const SizedBox(
                  width: 12,
                  child: Icon(Icons.search, color: hitam80),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0), // Hilangkan padding
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: PrimaryColor.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.tune_rounded),
            color: Colors.white,
            onPressed: () {
              _selectDate(context);
            },
          ),
        )
      ],
    );
  }
}


/*
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
*/