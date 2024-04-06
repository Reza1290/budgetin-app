import 'package:budgetin/layout.dart';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/dummy.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/detail_transaksi_sheet.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:budgetin/widgets/transaksi/card_sisa_saldo.dart';
import 'package:budgetin/widgets/transaksi/edit_transaksi.dart';
import 'package:budgetin/widgets/transaksi/filter.dart';
import 'package:budgetin/widgets/modal/modal_detail_transaksi.dart';
import 'package:budgetin/widgets/riwayat.dart';
import 'package:budgetin/widgets/search_bar.dart';
import 'package:flutter/material.dart';
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
      setState(() {
        isVisible = !_focusNode.hasFocus;
      });
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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Visibility(
                key: Key(isVisible.toString()),
                visible: isVisible,
                child: const CardSisaSaldo(),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Visibility(
                key: Key(isVisible.toString()),
                visible: isVisible,
                child: const SizedBox(
                  height: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SearchInput(
                  controller: searchController, focusNode: _focusNode),
            ),
            const SizedBox(
              height: 10,
            ),
            const Filter(),
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
                                      borderRadius: BorderRadius.circular(12),
                                      color: kuning50,
                                    ),
                                  ),
                                  Container(
                                    clipBehavior: Clip.none,
                                    width: 130,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                      child: RiwayatTransaksi(
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
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus riwayat ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                db!.deleteTransaction(index);
                Navigator.of(context).pop(); // Tutup dialog
                _onDismissed(context, index, true); // Hapus riwayat
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
