import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:flutter/material.dart';

Future<String?> showModalIconKategori(BuildContext context) {
  List<String> iconPath = [
    'assets/icons/lainnya.png',
    'assets/icons/uang.png',
    'assets/icons/makanan.png',
    'assets/icons/transportasi.png',
    'assets/icons/kesehatan.png',
    'assets/icons/olahraga.png',
    'assets/icons/belanja.png',
    'assets/icons/pakaian.png',
    'assets/icons/hewan.png',
    'assets/icons/pendidikan.png',
    'assets/icons/bahan_makanan.png',
    'assets/icons/bensin.png',
    'assets/icons/minuman.png',
    'assets/icons/teknologi.png',
    'assets/icons/kecantikan.png',
    'assets/icons/hiburan.png',
  ];

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return BudgetinModal(
        title: TitleModal(
          title: 'Hello',
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            child: GridView.count(
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
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(201, 218, 255, 1),
      ),
      child: Center(
        child: ClipRRect(
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context, path);
    },
  );
}

