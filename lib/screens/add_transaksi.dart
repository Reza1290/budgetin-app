import 'dart:async';

import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:budgetin/widgets/calendar.dart';

class AddTransaksi extends StatefulWidget {
  final int categoryId;
  const AddTransaksi({super.key, required this.categoryId});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  AppDb database = AppDb();

  DateTime selectedDate = DateTime.now();
  String? nama;
  String? nominal;
  String? deskripsi;
  bool isFormSubmitted = false;

  DateTime now = DateTime.now();

  Future insert(String name, String description, int amount, DateTime date,
      int categoryId) async {
    final row = await database.into(database.transactions).insertReturning(
        TransactionsCompanion.insert(
            name: name,
            description: description,
            category_id: categoryId,
            amount: amount,
            transaction_date: date));

    print(row);
  }

  TextEditingController nameTransaksiController = TextEditingController();
  TextEditingController amountTransaksiController = TextEditingController();
  TextEditingController deskripsiTransaksiController = TextEditingController();
  TextEditingController dateTransaksiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6.0),
            TextFormField(
              controller: nameTransaksiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                hintText: 'Masukkan nama transaksi',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                errorText: isFormSubmitted && (nama == null || nama!.isEmpty)
                    ? 'Nama transaksi tidak boleh kosong'
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  nama = value;
                });
              },
            ),
            const SizedBox(height: 15.0),
            const Text(
              "Nominal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6.0),
            TextFormField(
              controller: amountTransaksiController,
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
                prefixStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                errorText:
                    isFormSubmitted && (nominal == null || nominal!.isEmpty)
                        ? 'Harap masukkan nominal transaksi'
                        : (nominal != null &&
                                !RegExp(r'^[0-9]+$').hasMatch(nominal!))
                            ? 'Nominal harus berupa angka'
                            : null,
              ),
              onChanged: (value) {
                setState(() {
                  nominal = value;
                });
              },
            ),
            const SizedBox(height: 15.0),
            const Text(
              "Deskripsi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6.0),
            TextFormField(
              controller: deskripsiTransaksiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                hintText: 'Masukkan deskripsi transaksi',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                errorText:
                    isFormSubmitted && (deskripsi == null || deskripsi!.isEmpty)
                        ? 'Deskripsi transaksi tidak boleh kosong'
                        : null,
              ),
              onChanged: (value) {
                setState(() {
                  deskripsi = value;
                });
              },
            ),
            const SizedBox(height: 15.0),
            const Text(
              "Tanggal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6.0),
            GestureDetector(
              onTap: () async {
                final DateTime? pickedDate =
                    await selectDate(context, selectedDate);
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: AbsorbPointer(
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
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFormSubmitted = true;
                    insert(
                        nameTransaksiController.text,
                        deskripsiTransaksiController.text,
                        int.parse(amountTransaksiController.text),
                        selectedDate,
                        widget.categoryId);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RiwayatTransaksiPage(),));
                  });
                  if (isInputValid()) {
                    _submitForm();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (isFormSubmitted &&
                (nama == null ||
                    nama!.isEmpty ||
                    nominal == null ||
                    nominal!.isEmpty ||
                    deskripsi == null ||
                    deskripsi!.isEmpty)) ...[
              const SizedBox(height: 5.0),
              const AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: 1,
                child: Text(
                  "",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form submitted successfully')),
    );
  }

  bool isInputValid() {
    if (nama != null &&
        nama!.isNotEmpty &&
        nominal != null &&
        nominal!.isNotEmpty &&
        RegExp(r'^[0-9]+$').hasMatch(nominal!) &&
        deskripsi != null &&
        deskripsi!.isNotEmpty) {
      return true;
    }
    return false;
  }
}
