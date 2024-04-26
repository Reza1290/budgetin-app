import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/widgets/category/detail/card_kategori_transaksi.dart';
import 'package:budgetin/widgets/delete_alert.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_card.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailKategoriPage extends StatefulWidget {
  const DetailKategoriPage({
    super.key,
    required this.category,
    required this.totalAmount,
  });
  final Category category;
  final int totalAmount;

  @override
  State<DetailKategoriPage> createState() => _DetailKategoriPageState();
}

class _DetailKategoriPageState extends State<DetailKategoriPage> {
  // late AppDb db;
  Stream<List<TransactionWithCategory>> getAllTransactions() {
    return db!.getTransactionWithCategory(widget.category.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        scrolledUnderElevation: 0,
        title: const Text(
          "Detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => deleteAlert(context, widget.category.id,
                  "Apakah anda yakin untuk menghapus?"),
              icon: Icon(Icons.delete_forever_rounded)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    CardKategoriTransaksi(
                        data: widget.category, total: widget.totalAmount),
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
                      TextCurrencyFormat.format(widget.totalAmount.toString()),
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
                      TextCurrencyFormat.format(
                          widget.category.total.toString()),
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
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: RiwayatTransaksiList(
              getAllTransactions: () => getAllTransactions(),
            ),
          ),
        ],
      ),
    );
  }
}
