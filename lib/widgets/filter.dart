import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';

var selectedService = 0;

class Service {
  static String semua = "Semua";
  static String hariIni = "Hari ini";
  static String mingguIni = "Minggu ini";
  static String bulanIni = "Bulan ini";
  static String tahunIni = "Tahun ini";

  static List<String> all() {
    return [semua, mingguIni, bulanIni, tahunIni];
  }
}

class Filter extends StatelessWidget {
  const Filter({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            selectedService = index; 
            (context as Element).markNeedsBuild();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: selectedService == index ? biru40 : null,
              border: selectedService == index
                  ? null
                  : Border.all(
                      color: const Color.fromRGBO(209, 209, 209, 1),
                      width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _buildText(
                Service.all()[index],
                12,
                FontWeight.w600,
                selectedService == index ? hitamPutih30 : const Color.fromRGBO(209, 209, 209, 1),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: Service.all().length,
      ),
    );
  }
}

Widget _buildText(
  String text,
  double size,
  FontWeight weight,
  Color color,
) {
  return Text(
    text, // Teks kosong karena TextStyle hanya bisa digunakan sebagai parameter dalam Widget Text
    style: TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ),
  );
}
