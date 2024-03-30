import 'package:budgetin/widgets/_pemanggilan_alert.dart';
import 'package:budgetin/widgets/card_kategori_transaksi.dart';
import 'package:budgetin/widgets/riwayat_transaksi.dart';
import 'package:flutter/material.dart';

class DetailKategoriPage extends StatelessWidget {
  const DetailKategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0),
            child: ListView(
              children: const <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Kategori Transaksi',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    CardKategoriTransaksi(),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Uang Terpakai',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp. 50.000',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Divider(
                  height: 5.0,
                ),
                SizedBox(
                  height: 17.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Uang Max',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp. 100.000',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Divider(
                  height: 5.0,
                ),
                SizedBox(
                  height: 35.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Riwayat Transaksi',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    PemanggilanAlert(),
                  ],
                ),
                SizedBox(
                  height: 11.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
                RiwayatTransaksi(),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
