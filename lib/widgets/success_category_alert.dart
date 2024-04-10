import 'package:flutter/material.dart';

void showSuccessCategoryAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });

      return PopScope(
        canPop: false,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              // backgroundColor: Colors.white,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 240.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/succes_kategory_alert.png',
                      width: 173.0,
                      height: 159.0,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
