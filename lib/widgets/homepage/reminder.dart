import 'package:budgetin/screens/faq_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Reminder extends StatelessWidget {
  const Reminder({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset('assets/images/ORY.svg');

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FaqPage(),
          )),
      child: Stack(
        children: [
          Container(
            width: 360,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 73, 121, 194),
                  Color.fromARGB(255, 77, 148, 255)
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bingung Menggunakan\nBudgetin?",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Yuk pahami cara penggunaan aplikasi Budgetin\ndengan mengetuk banner ini!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: svg,
            width: 140,
            right: -35,
            top: -30,
          ),
        ],
      ),
    );
  }
}
