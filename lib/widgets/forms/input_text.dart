import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      this.controller,
      this.hintText,
      this.focusNode,
      this.isMandatory = true});
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool? isMandatory;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => isMandatory!
          ? (value == null || value.isEmpty || value.trim().isEmpty)
              ? '$hintText tidak boleh kosong'
              : (value.length > 92)
                  ? 'Masukkan $hintText Singkat'
                  : null
          : (value != null && value.length > 92)
              ? 'Masukkan $hintText Singkat'
              : null,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: BudgetinColors.hitamPutih40,
            )),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: BudgetinColors.hitamPutih40,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        // errorText:
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
