import 'package:budgetin/models/database.dart';
import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> showModal(
    BuildContext context, String title, Widget content, Function? run) {
  final formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                right: -8,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    weight: 100,
                  ),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
        ),
        surfaceTintColor: Colors.white,
        contentPadding: const EdgeInsets.only(
            top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
        content: Form(key: formKey, child: content),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 45,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: PrimaryColor.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  run!;
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Simpan', 
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
          )
        ],
      );
    },
  );
}
