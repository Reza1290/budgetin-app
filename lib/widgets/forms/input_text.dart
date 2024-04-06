import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({super.key, required this.controller, this.hintText, this.focusNode});
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => (value == null || value.isEmpty)
          ? '$hintText tidak boleh kosong'
          : null,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        // errorText:
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
