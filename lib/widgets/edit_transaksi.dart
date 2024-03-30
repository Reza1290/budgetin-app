import 'package:flutter/material.dart';

class EditTransaksi extends StatefulWidget {
  const EditTransaksi({super.key});

  @override
  State<EditTransaksi> createState() => _EditTransaksiState();
}

class _EditTransaksiState extends State<EditTransaksi> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(width: 20),
                const Text(
                  'Edit Transaksi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTitleText('Nama'),
            const SizedBox(height: 6.0),
            _buildTextFormField('Nasi Goreng', height: 40),
            const SizedBox(height: 10.0),
            _buildTitleText('Nominal'),
            const SizedBox(height: 6.0),
            _buildTextFormField('Rp 20.000', height: 40),
            const SizedBox(height: 10.0),
            _buildTitleText('Deskripsi'),
            const SizedBox(height: 6.0),
            _buildTextFormField('Beli nasi goreng di gebang', height: 40),
            const SizedBox(height: 10.0),
            _buildTitleText('Tanggal'),
            const SizedBox(height: 6.0),
            _buildDateField(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  _simpanTransaksi(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.blue; // Warna saat dihover
                    }
                    return Colors.grey; // Warna default
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
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
  }

  Widget _buildDateField() {
    return SizedBox(
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          suffixIcon: const Icon(Icons.calendar_month),
          hintText:
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
}

void _simpanTransaksi(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Transaksi berhasil disimpan!'),
      duration: Duration(seconds: 2),
    ),
  );
  Navigator.pop(context);
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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    ),
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
