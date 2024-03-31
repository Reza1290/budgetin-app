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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
              return Slidable(
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
