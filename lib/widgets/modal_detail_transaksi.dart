import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/dummy.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/widgets/detail_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

AppDb _db = AppDb();

DateFormat formatter = DateFormat('EEEE, d MMMM y', 'id_ID');

class ModalDetailTransaksi extends StatelessWidget {
  final TransactionWithCategory detailTransaksi;
  const ModalDetailTransaksi({Key? key, required this.detailTransaksi})
      : super(key: key);

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
        padding: const EdgeInsets.only(
          left: 30, // Jarak kiri
          right: 30, // Jarak kanan
          top: 30, // Jarak atas (opsional)
          bottom: 30, // Jarak bawah (opsional)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Detail Transaksi',
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
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(201, 218, 255, 1),
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          detailTransaksi.category.icon,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0), // Jarak antara gambar dan teks
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      detailTransaksi.category.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleText('Nama'),
                const SizedBox(
                    height: 6.0), // Jarak antara judul dan form field
                _buildTextFormField(detailTransaksi.transaction.name),
                const SizedBox(
                    height: 10.0), // Jarak antara field dan judul berikutnya
                _buildTitleText('Nominal'),
                const SizedBox(
                    height: 6.0), // Jarak antara judul dan form field
                _buildTextFormField(
                    detailTransaksi.transaction.amount.toString()),
                const SizedBox(
                    height: 10.0), // Jarak antara field dan judul berikutnya
                _buildTitleText('Deskripsi'),
                const SizedBox(
                    height: 6.0), // Jarak antara judul dan form field
                _buildTextFormField(detailTransaksi.transaction.description),
                const SizedBox(
                    height: 10.0), // Jarak antara field dan judul berikutnya
                _buildTitleText('Tanggal'),
                const SizedBox(
                    height: 6.0), // Jarak antara judul dan form field
                _buildTextFormField(
                    detailTransaksi.transaction.transaction_date.toString()),
              ],
            ), // Jarak antara gambar dan teks
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 40,
        child: TextFormField(
          readOnly: true,
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
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ),
    ],
  );
}
