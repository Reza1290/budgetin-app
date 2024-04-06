import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';

class CardSisaSaldo extends StatelessWidget {
  const CardSisaSaldo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 293.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            Color.fromRGBO(73, 121, 194, 1),
            Color.fromRGBO(75, 125, 201, 1),
            Color.fromRGBO(75, 131, 215, 1),
            Color.fromRGBO(81, 144, 239, 1),
            Color.fromRGBO(77, 148, 255, 1),
          ],
        ),
      ),
      padding:const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width:
                    20, // Ukuran lingkaran, disesuaikan dengan kebutuhan Anda
                height:
                    20, // Ukuran lingkaran, disesuaikan dengan kebutuhan Anda
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
                  color:
                      biru10, // Warna latar belakang lingkaran, sesuaikan dengan kebutuhan Anda
                ),
                child: const Center(
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: Color.fromARGB(255, 0, 0,
                        0), // Warna ikon, sesuaikan dengan kebutuhan Anda
                    size: 20, // Ukuran ikon, sesuaikan dengan kebutuhan Anda
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              _buildText(
                  "Sisa Saldo",
                   15,
                   FontWeight.w600,
                  putih30)
            ],
          ),
          _buildText(
              "Rp 5.000.000",
               24,
              FontWeight.w800,
              putih30),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContainerSaldo(
                  saldo: "Rp 200.000",
                  textColour: merah60,
                  bgColour: merah10,
                  icon: Icons.arrow_upward_rounded),
               SizedBox(
                width: 10,
              ),
              ContainerSaldo(
                  saldo: "Rp 3.500.00",
                  textColour: hijau80,
                  bgColour: hijau10,
                  icon: Icons.arrow_downward_rounded)
            ],
          )
        ],
      ),
    );
  }
}

class ContainerSaldo extends StatelessWidget {
  final String saldo;
  final Color textColour;
  final Color bgColour;
  final IconData icon;
  const ContainerSaldo(
      {super.key,
      required this.saldo,
      required this.textColour,
      required this.bgColour,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColour,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.shade700,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: const Offset(3.0, 3.0))
        ],
      ),
      child: Row(
        children: [
          Icon(
            size: 20,
            icon,
            color: textColour,
          ),
          const SizedBox(
            width: 5,
          ),
         _buildText(
              saldo, 12, FontWeight.w600, textColour)
        ],
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
