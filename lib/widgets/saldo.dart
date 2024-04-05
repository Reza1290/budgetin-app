import 'package:budgetin/models/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Saldo extends StatefulWidget {
  const Saldo({super.key});

  @override
  State<Saldo> createState() => _SaldoState();
}

AppDb _db = AppDb();

int saldo = 0;
Future<int> totalExpense() async {
  // Ubah deklarasi totalExpense menjadi Future<int>
  return await _db.totalExpense(); // Tambahkan await di sini
}

TextEditingController saldoController = TextEditingController();
final formatter = NumberFormat('#,###.##', 'id');

class _SaldoState extends State<Saldo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 77, 148, 255),
                  Color.fromARGB(255, 229, 225, 249)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saldo",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white),
                ),
                const SizedBox(height: 7),
                InkWell(
                    onTap: () => _modalTambahSaldo(context),
                    child: Row(
                      children: [
                        Text(
                          "Rp ${formatter.format(saldo)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.edit,
                          size: 13,
                          color: Colors.white,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(width: 12), // Tambahkan jarak antara dua container
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 77, 77),
                  Color.fromARGB(255, 255, 218, 247)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Pengeluaran",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white),
                ),
                SizedBox(height: 7),
                FutureBuilder<int>(
                    future: totalExpense(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        int expense = snapshot.data ??
                            0; // Menggunakan nilai default jika snapshot.data null
                        return Text(
                          "Rp ${formatter.format(expense)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.white),
                        );
                      }
                    })
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _modalTambahSaldo(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const Center(
                  child: Text(
                    'Tambah Saldo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Positioned(
                  right: -8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      weight: 100,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                  ),
                )
              ],
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "Jumlah",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      TextField(
                        controller: saldoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly // Hanya mengizinkan input angka
                        ],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 8.0,
                          ),
                          hintText: "100000",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(131, 180, 255, 100),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(131, 180, 255, 100),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(131, 180, 255, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(131, 180, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                onPressed: () => {
                  setState(() {
                    saldo = int.parse(saldoController.text);
                  }),
                  Navigator.pop(context)
                },
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
