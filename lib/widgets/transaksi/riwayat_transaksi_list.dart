import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/edit_transaksi.dart';
import 'package:budgetin/widgets/modal_detail_transaksi.dart';
import 'package:budgetin/widgets/riwayat.dart';
import 'package:flutter/material.dart';
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
              return Center(
                child: CircularProgressIndicator(),
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
                return const Center(child: Text("Belum ada transaksi"));
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
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (_) => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditTransaksi();
                    },
                  ),
                  backgroundColor: kuning50,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_square,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                SlidableAction(
                  onPressed: (value) {
                    _confirmDelete(context, transaction.transaction.id);
                  },
                  autoClose: true,
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModalDetailTransaksi(
                      detailTransaksi: transaction,
                    );
                  },
                );
              },
              child: Container(
                child: RiwayatTransaksi(
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
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // _onDismissed(context, index, true);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
