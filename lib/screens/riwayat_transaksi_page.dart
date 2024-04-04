import 'package:budgetin/layout.dart';
import 'package:budgetin/models/dummy.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/transaksi/card_sisa_saldo.dart';
import 'package:budgetin/widgets/edit_transaksi.dart';
import 'package:budgetin/widgets/transaksi/filter.dart';
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
  final TextEditingController searchController = TextEditingController();

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
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            const CardSisaSaldo(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SearchInput(
                controller: searchController,
              ),
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
          child: ListView.builder(
            itemCount: riwayatList.length,
            itemBuilder: (context, index) {
              final riwayat = riwayatList[index];
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                return const EditTransaksi();
                              },
                            ),
                            backgroundColor: kuning50,
                            foregroundColor: Colors.white,
                            icon: Icons.edit_square,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0)),
                          ),
                          SlidableAction(
                            onPressed: (value) {
                              _confirmDelete(context,
                                  index); // Tampilkan dialog konfirmasi sebelum menghapus
                            },
                            autoClose: true,
                            backgroundColor: merah50,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0)),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ModalDetailTransaksi(
                                  detailTransaksi: riwayat);
                            },
                          );
                        },
                        child: Container(
                          child: RiwayatTransaksi(
                            title: riwayat.title,
                            tanggal: riwayat.tanggal,
                            money: riwayat.money,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onDismissed(BuildContext context, int index, bool delete) {
    if (delete) {
      setState(() {
        riwayatList.removeAt(index);
      });
      _hapusTransaksi(context); // Panggil fungsi untuk menampilkan snackbar
    }
  }

  void _hapusTransaksi(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaksi berhasil dihapus!'),
        duration: Duration(seconds: 2),
      ),
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
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
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
