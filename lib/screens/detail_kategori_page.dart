import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/widgets/_pemanggilan_alert.dart';
import 'package:budgetin/widgets/card_kategori_transaksi.dart';
import 'package:budgetin/widgets/riwayat.dart';
import 'package:budgetin/widgets/riwayat_transaksi.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailKategoriPage extends StatefulWidget {
  const DetailKategoriPage({super.key, required this.categoryId});
  final int categoryId;
  @override
  State<DetailKategoriPage> createState() => _DetailKategoriPageState();
}

class _DetailKategoriPageState extends State<DetailKategoriPage> {
  // late AppDb _db;
  final AppDb _db = AppDb.getInstance();

  Stream<List<TransactionWithCategory>> getAllTransactions() {
    return _db.getTransactionWithCategory(widget.categoryId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Kategori Transaksi",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
            child: Column(
              children: [
                Column(
                  children: <Widget>[
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
                    // PemanggilanAlert(),
                  ],
                ),
              ],
            ),
          ),
          RiwayatTransaksiList(
            getAllTransactions: () => getAllTransactions(),
          ),
        ],
      ),
    );
  }
}
