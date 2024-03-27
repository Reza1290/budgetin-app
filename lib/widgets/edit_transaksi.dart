import 'package:flutter/material.dart';

class EditTransaksi extends StatefulWidget {
  const EditTransaksi({Key? key}) : super(key: key);

  @override
  State<EditTransaksi> createState() => _EditTransaksiState();
}

class _EditTransaksiState extends State<EditTransaksi> {
  DateTime selectedDate = DateTime.now();
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _modal(context),
          child: const Text('Edit Transaksi'),
        ),
      ),
    );
  }

  Future<void> _modal(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 325,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          'Edit Transaksi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildTitleText('Nama'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Nasi Goreng', height: 40),
                    SizedBox(height: 10.0),
                    _buildTitleText('Nominal'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Rp 20.000', height: 40),
                    SizedBox(height: 10.0),
                    _buildTitleText('Deskripsi'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Beli nasi goreng di gebang', height: 40),
                    SizedBox(height: 10.0),
                    _buildTitleText('Tanggal'),
                    SizedBox(height: 6.0),
                    _buildDateField(),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isButtonPressed = true;
                          });
                          _simpanTransaksi(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (isButtonPressed) {
                                return Colors.blue; // Warna saat tombol dipencet
                              } else {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.blue.withOpacity(0.8); // Warna saat dihover
                                }
                                return Colors.grey; // Warna default
                              }
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTitleText(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextFormField(String content, {double? height}) {
    return SizedBox(
      height: height,
      child: TextFormField(
        initialValue: content,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return SizedBox(
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          suffixIcon: Icon(Icons.calendar_month),
          hintText:
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            setState(() {
              selectedDate = pickedDate;
            });
          }
        },
      ),
    );
  }

  void _simpanTransaksi(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaksi berhasil disimpan!'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }
}
