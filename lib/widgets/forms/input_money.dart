import 'package:budgetin/providers/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMoney extends StatelessWidget {
  const InputMoney(
      {super.key, required this.controller, required this.fontSize});
  final TextEditingController controller;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        prefix: const Text("Rp "),
        prefixStyle: TextStyle(
          color: Colors.grey,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        // errorText:
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyFormat()
      ],
      validator: (nominal) => (nominal == null || nominal.isEmpty)
          ? 'Harap masukkan nominal transaksi'
          : (!RegExp(r'^[0-9]+$').hasMatch(nominal.replaceAll('.', '')))
              ? 'Nominal harus berupa angka'
              : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
