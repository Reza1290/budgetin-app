import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransaksiKosong extends StatelessWidget {
  const TransaksiKosong({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 85,
            child: SvgPicture.asset('assets/images/handling/kosong.svg'),
          ),
          Text(
            'Transaksi Tidak Tersedia',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Text(
            'Buat Transaksi Terlebih Dahulu',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
          )
        ],
      ),
    ));
  }
}
