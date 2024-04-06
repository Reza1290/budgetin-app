import 'package:flutter/material.dart';

void showSuccessAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });

      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(52.0, 14.0, 52.0, 41.0),
        content: SizedBox(
          height: 220.0,
          width: 220.0,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/successalert.png',
                width: 173.0,
                height: 159.0,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
