import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMoney extends StatelessWidget {
  const InputMoney({
    super.key,
    this.controller,
    this.hintText,
    required this.fontSize,
    this.formKey,
    this.focusNode,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double fontSize;
  final String? hintText;
  final Key? formKey;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: formKey,

      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        prefixText: 'Rp. ',
        hintText: hintText ?? '',
        hintStyle: TextStyle(
          fontSize: 14,
          color: BudgetinColors.hitamPutih40,
          fontWeight: FontWeight.w400,
        ),
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
      validator: (nominal) =>
          (nominal == null || nominal.isEmpty || nominal == '0')
              ? 'Harap masukkan nominal'
              : (!RegExp(r'^[0-9]+$').hasMatch(nominal.replaceAll('.', '')))
                  ? 'Nominal harus berupa angka'
                  : (nominal.replaceAll('.', '').length > 16)
                      ? 'Nominal Terlalu Banyak'
                      : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
