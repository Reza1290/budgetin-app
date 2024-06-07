import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/detail_kategori.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/category/detail/card_kategori_transaksi.dart';
import 'package:budgetin/widgets/category/detail_category_actions.dart';
import 'package:budgetin/widgets/main/select_category_page.dart';
import 'package:budgetin/widgets/transaksi/create_update_transaksi.dart';
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
      backgroundColor: BudgetinColors.hitamPutih10,
      resizeToAvoidBottomInset: false,
      appBar: AppBar( 
        backgroundColor: Colors.white,
        surfaceTintColor: null,
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        scrolledUnderElevation: 0,
        title: const Text(
          "Detail Kategori",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [DetailCategoryActions(category: widget.category)],
      ),
      body: ListView(
        children: [
          StreamBuilder<DetailKategori>(
            stream: db!.getDetailCategory(widget.category.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final detailKategori = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          CardKategoriTransaksi(
                            data: detailKategori.category,
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Uang Terpakai',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            TextCurrencyFormat.format(
                                detailKategori.totalAmount.toString()),
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Divider(height: 5.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Uang Sisa',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            TextCurrencyFormat.format(
                                detailKategori.remainAmount.toString()),
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Divider(height: 5.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Uang Max',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            TextCurrencyFormat.format(
                                detailKategori.category.total.toString()),
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Divider(height: 5.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Riwayat Transaksi',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CreateUpdateTransaksiPage(
                                  isEditPage: false,
                                  isOnCategory: true,
                                  categoryId: widget.category.id,
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeIn;

                                  final tween = Tween(begin: begin, end: end);
                                  final curvedAnimation = CurvedAnimation(
                                    parent: animation,
                                    curve: curve,
                                  );

                                  return SlideTransition(
                                    position: tween.animate(curvedAnimation),
                                    child: child,
                                  );
                                },
                              ));
                            },
                            child: Text(
                              'Buat',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                          )
                          // PemanggilanAlert(),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // Handle error case
                return Text('Tidak Ditemukan');
              } else {
                // Handle loading case
                return Center(
                    child: Image.asset(
                        'assets/images/handling/white_loading.gif'));
              }
            },
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
