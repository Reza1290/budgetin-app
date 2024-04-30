import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final bool blok;
  final void Function() onPressed;
  const ButtonCustom(
      {super.key,
      required this.title,
      required this.blok,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              blok ? Color(0xFF0C5FDD): Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: blok ? Colors.transparent : Color(0xFF0C5FDD)),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: blok ? Colors.white : Color(0xFF0C5FDD),
          ),
        ),
      ),
    );
  }
}
