import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Saldo extends StatefulWidget {
  const Saldo({super.key});

  @override
  State<Saldo> createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                        Expanded(
                          child: Text(
                            "Rp 5.000.000.000.00",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white),
                          ),
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
                Text(
                  "Rp 5.000.000",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white),
                )
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
          surfaceTintColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "Jumlah",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
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
                          prefix: Text("Rp "),
                          prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
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
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
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
