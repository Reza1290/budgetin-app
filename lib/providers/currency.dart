import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    final money = NumberFormat("###,###,###", "ID");
    String newText = money.format(value);
    return newValue.copyWith(
        text: newText.replaceAll(',', '.'),
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class TextCurrencyFormat {
  static format(val) {
    val = double.parse(val);
    final money = NumberFormat("###,###,###", "ID");
    String newValue = money.format(val);
    return "Rp. ${newValue.replaceAll(',', '.')}";
  }

  static toInt(String val) {
    int saldo = int.parse(val.replaceAll('.', ''));
    return saldo;
  }
}
