import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context, DateTime initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white, 
            surface: Colors.white, 
            onSurface: Colors.black, 
          ),
          dialogBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontFamily: 'Nunito', 
              fontSize: 18, 
              fontWeight: FontWeight.w400, 
              color: Colors.black,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Nunito', 
              fontSize: 16, 
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
