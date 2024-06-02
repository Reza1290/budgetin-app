import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/detail_transaksi_sheet.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:budgetin/widgets/reusable/transaksi_kosong.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:budgetin/widgets/transaksi/create_update_transaksi.dart';
import 'package:budgetin/widgets/transaksi/edit_transaksi.dart';
import 'package:budgetin/widgets/modal/modal_detail_transaksi.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RiwayatTransaksiList extends StatelessWidget {
  final Stream<List<TransactionWithCategory>> Function() getAllTransactions;

  const RiwayatTransaksiList({
    Key? key,
    required this.getAllTransactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        child: StreamBuilder<List<TransactionWithCategory>>(
          stream: getAllTransactions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 55,
                child: Row(
                  children: [
                    Container(
                      // alignment: ,
                      alignment: Alignment.topLeft,
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        // alignment: ,
                        alignment: Alignment.topLeft,
                        height: 54,
                        // width: MediaQuery.of(context).size.width / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          color: Colors.black.withOpacity(0.04),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final transactions = snapshot.data;
              if (transactions != null && transactions.isNotEmpty) {
                return Column(
                  children: transactions.map((transaction) {
                    return _buildSlidableTransaction(context, transaction);
                  }).toList(),
                );
              } else {
                return TransaksiKosong();
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlidableTransaction(
      BuildContext context, TransactionWithCategory transaction) {
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
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              extentRatio: 0.35,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (BuildContext context) {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CreateUpdateTransaksiPage(
                        categoryId: transaction.category.id,
                        dataTransaction: transaction,
                        isEditPage: true,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
                  backgroundColor: kuning50,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_square,
                  padding: EdgeInsets.all(8),
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                SlidableAction(
                  onPressed: (value) {
                    showModalInformation(
                        context,
                        'assets/images/modal_gagal.svg',
                        "Hapus Transaksi",
                        false, onPressed: () {
                      db!.deleteTransaction(transaction.transaction.id);
                      Navigator.of(context).pop();

                      _onDismissed(context, transaction.transaction.id, true);
                    });
                  },
                  autoClose: true,
                  padding: EdgeInsets.all(8),
                  backgroundColor: merah50,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                showDetailTransaksiSheet(context, transaction);
              },
              child: Container(
                child: RiwayatTransaksiCard(
                  category: transaction.category.name,
                  title: transaction.transaction.name,
                  tanggal: transaction.transaction.transaction_date.toString(),
                  money: transaction.transaction.amount.toString(),
                  icon: transaction.category.icon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onDismissed(BuildContext context, int index, bool delete) {
    if (delete) {
      showModalInformation(
          context, 'assets/images/alertYes.svg', "Berhasil Dihapus", true);
      // showSuccessAlert(context, "Berhasil Dihapus");
    } else {
      // showFailedAlert(context, "Gagal Terhapus");
      showModalInformation(
          context, 'assets/images/alertNo.svg', "Gagal Terhapus", true);
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
