import 'package:budgetin/main.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:flutter/material.dart';

void deleteAlert(BuildContext context, int index, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 250.0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Image.asset(
                'assets/images/delete_alertt.png',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Color(0xFFA3A3A3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 56,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Color(0xFF1D77FF),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        db!.deleteCategory(index);
                        Navigator.of(context).pop();
                        _onDismissed(context, index, true);
                      },
                      child: const Text(
                        'Ya',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void _onDismissed(BuildContext context, int index, bool delete) {
  if (delete) {
    showSuccessAlert(context, "Berhasil Dihapus");
  } else {
    showFailedAlert(context, "Gagal Terhapus");
  }
}
