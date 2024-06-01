import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/detail_transaksi_sheet.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:budgetin/widgets/transaksi/saldo_card.dart';
import 'package:budgetin/widgets/transaksi/edit_transaksi.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_card.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({Key? key}) : super(key: key);

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  // late AppDb db;

  Stream<List<TransactionWithCategory>> getAllTransactions() {
    return db!.getAllTransactionWithCategory();
  }

  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if (searchController.text != '') {
        setState(() {
          isVisible = false;
        });
      } else {
        setState(() {
          isVisible = !_focusNode.hasFocus;
        });
      }
    });
    // db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // db.close();
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BudgetinColors.hitamPutih10,
      appBar: AppBar(
        leading: Container(),
        scrolledUnderElevation: 0,
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              switchInCurve: Curves.easeInCirc,
              child: Visibility(
                key: Key(isVisible.toString()),
                visible: isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SaldoCard(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: InputSearch(
                controller: searchController,
                focusNode: _focusNode,
                showFilter: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Filter(),
            const SizedBox(
              height: 10,
            ),
            _riwayatTransaksi(context),
          ],
        ),
      ),
    );
  }

  Widget _riwayatTransaksi(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: StreamBuilder<List<TransactionWithCategory>>(
              stream: getAllTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final transaction = snapshot.data![index];
                          return Stack(
                            alignment: Alignment.centerRight,
                            clipBehavior: Clip.none,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    clipBehavior: Clip.none,
                                    width: 80,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      color: kuning50,
                                    ),
                                  ),
                                  Container(
                                    clipBehavior: Clip.none,
                                    width: 60,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                      color: merah50,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Slidable(
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.35,
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (BuildContext context) {
                                          Navigator.of(context)
                                              .push(PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                EditTransaksi(
                                                    transaction: transaction),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(0.0, 1.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeIn;

                                              final tween =
                                                  Tween(begin: begin, end: end);
                                              final curvedAnimation =
                                                  CurvedAnimation(
                                                parent: animation,
                                                curve: curve,
                                              );

                                              return SlideTransition(
                                                position: tween
                                                    .animate(curvedAnimation),
                                                child: child,
                                              );
                                            },
                                          ));
                                        },
                                        backgroundColor: kuning50,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit_square,
                                        padding: EdgeInsets.all(8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      SlidableAction(
                                        onPressed: (value) {
                                          _confirmDelete(
                                              context,
                                              transaction.transaction
                                                  .id); // Tampilkan dialog konfirmasi sebelum menghapus
                                        },
                                        autoClose: true,
                                        backgroundColor: merah50,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        padding: EdgeInsets.all(8),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(9),
                                            bottomRight: Radius.circular(9)),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDetailTransaksiSheet(
                                          context, transaction);
                                    },
                                    child: Container(
                                      child: RiwayatTransaksiCard(
                                        category: transaction.category.name,
                                        title: transaction.transaction.name,
                                        tanggal: transaction
                                            .transaction.transaction_date
                                            .toString(),
                                        money: transaction.transaction.amount
                                            .toString(),
                                        icon: transaction.category.icon,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Text("Belum ada transaksi");
                    }
                  } else {
                    return const Text("Belum ada transaksi");
                  }
                }
              },
            )),
      ),
    );
  }

  void _onDismissed(BuildContext context, int index, bool delete) {
    if (delete) {
      showSuccessAlert(context, "Berhasil Dihapus");
    } else {
      showFailedAlert(context, "Gagal Terhapus");
    }
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 250.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Image.asset(
                    'assets/images/delete_alertt.png',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      "Hapus Transaksi?",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 60,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Tutup dialog
                          },
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              color: Color(0xFFA3A3A3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 56,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color(0xFF1D77FF),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            db!.deleteTransaction(index);
                            _onDismissed(context, index, true);
                          },
                          child: const Text(
                            'Ya',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
