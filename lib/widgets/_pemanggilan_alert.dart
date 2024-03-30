
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:flutter/material.dart';

class PemanggilanAlert extends StatefulWidget {
  const PemanggilanAlert({super.key});

  @override
  State<PemanggilanAlert> createState() => _PemanggilanAlertState();
}

class _PemanggilanAlertState extends State<PemanggilanAlert> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            // CONT PEMANGGILAN ALERT
            showFailedAlert(context, 'Contoh manggil bang');
          });
        },
        icon: const Icon(Icons.remove_red_eye_rounded));
  }
}
