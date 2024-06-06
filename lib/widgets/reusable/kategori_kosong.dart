import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KategoriKosong extends StatelessWidget {
  const KategoriKosong({
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
            child: SvgPicture.asset('assets/images/handling/not_found.svg'),
          ),
          Text(
            'Kategori Kosong',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Text(
            'Buat Kategori terlebih dahulu',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8),
          )
        ],
      ),
    ));
  }
}
