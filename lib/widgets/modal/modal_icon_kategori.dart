import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<String?> showModalIconKategori(BuildContext context) {
  List<String> iconPath = [
    'assets/icons/null.svg',
    'assets/icons/Makanan.svg',
    'assets/icons/Minuman.svg',
    'assets/icons/Kendaraan.svg',
    'assets/icons/Pakaian.svg',
    'assets/icons/Kesehatan.svg',
    'assets/icons/Keluarga.svg',
    'assets/icons/Pendidikan.svg',
    'assets/icons/Olahraga.svg',
    'assets/icons/Uang.svg',
    'assets/icons/Rumah.svg',
    'assets/icons/Belanja.svg',
    'assets/icons/Teknologi.svg',
    'assets/icons/Liburan.svg',
    'assets/icons/Hiburan.svg',
    'assets/icons/Peliharaan.svg',
  ];

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return BudgetinModal(
        title: TitleModal(
          title: 'Pilih Ikon',
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              crossAxisCount: 4,
              shrinkWrap: true,
              children: List.generate(16, (index) {
                return iconComponent(iconPath[index], context);
              }),
            ),
          ),
        ),
      );
    },
  );
}

GestureDetector iconComponent(String path, BuildContext context) {
  return GestureDetector(
    child: Container(
      width: 56,
      height: 56,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: path == 'assets/icons/null.svg'
            ? BudgetinColors.biru30
            : BudgetinColors.biru10,
      ),
      child: Center(
        child: ClipRRect(
          child: SvgPicture.asset(
            path,
            width: 35,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context,
          path == 'assets/icons/null.svg' ? 'assets/icons/Lainnya.svg' : path);
    },
  );
}
