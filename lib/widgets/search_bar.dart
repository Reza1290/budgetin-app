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
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
                        color: putih40,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const SizedBox(
                      width: 12,
                      child: Icon(Icons.search, color: hitam80),
                    ),
                    contentPadding: EdgeInsets.zero, // Hilangkan padding
                  ),
                ),
              ),
            )),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 0,
          child: IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: const Icon(
              Icons
                  .calendar_month_rounded, // Mengubah dari 'Icons.calendar_month_rounded' menjadi 'Icons.calendar_today_rounded'
              size: 35,
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
