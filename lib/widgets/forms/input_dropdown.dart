import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  final List<String> dropdownItems;

  DropdownInput({Key? key, required this.dropdownItems}) : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String _selectedValue = ''; // Nilai yang dipilih dalam dropdown

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down),
          value: _selectedValue.isNotEmpty ? _selectedValue : null,
          hint: const Text('Pilih'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue ?? '';
            });
          },
          items: widget.dropdownItems
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
