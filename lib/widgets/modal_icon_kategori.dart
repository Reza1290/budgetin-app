import 'package:flutter/material.dart';

Future<String?> showModalIconKategori(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Icon Kategori',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                children: <Widget>[
                  iconComponent('assets/icons/lainnya.png', context),
                  iconComponent('assets/icons/uang.png', context),
                  iconComponent('assets/icons/makanan.png', context),
                  iconComponent('assets/icons/transportasi.png', context),
                  iconComponent('assets/icons/kesehatan.png', context),
                  iconComponent('assets/icons/olahraga.png', context),
                  iconComponent('assets/icons/belanja.png', context),
                  iconComponent('assets/icons/pakaian.png', context),
                  iconComponent('assets/icons/hewan.png', context),
                  iconComponent('assets/icons/pendidikan.png', context),
                  iconComponent('assets/icons/bahan_makanan.png', context),
                  iconComponent('assets/icons/bensin.png', context),
                  iconComponent('assets/icons/minuman.png', context),
                  iconComponent('assets/icons/teknologi.png', context),
                  iconComponent('assets/icons/kecantikan.png', context),
                  iconComponent('assets/icons/hiburan.png', context),
                ],
              ),
              const SizedBox(height: 20),
            ],
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
            height: 30,
            width: 30,
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
