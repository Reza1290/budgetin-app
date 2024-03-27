import 'package:budgetin/layout.dart';
import 'package:budgetin/models/dummy.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/card_sisa_saldo.dart';
import 'package:budgetin/widgets/edit_transaksi.dart';
import 'package:budgetin/widgets/filter.dart';
import 'package:budgetin/widgets/modal_detail_transaksi.dart';
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
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Riwayat Transaksi",
      content: [
        const CardSisaSaldo(),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SearchInput(),
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
    );
  }
}

Widget _riwayatTransaksi(BuildContext context) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemCount: riwayatList.length,
        itemBuilder: (context, index) {
          final riwayat = riwayatList[index];
          return Slidable(
            key: UniqueKey(), // Key yang unik sesuai dengan indeks item
            // controller: controller, // Menggunakan controller yang telah diinisialisasi
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  // flex: 2,
                  onPressed: (_) => (showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const EditTransaksi();
                    },
                  )),
                  backgroundColor: kuning50,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_square,
                ),
                SlidableAction(
                  onPressed: (_) => (),
                  backgroundColor: merah50,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModalDetailTransaksi(detailTransaksi: riwayat);
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: RiwayatTransaksi(
                  title: riwayat.title,
                  tanggal: riwayat.tanggal,
                  money: riwayat.money,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
