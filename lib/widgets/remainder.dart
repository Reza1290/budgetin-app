import 'package:flutter/material.dart';

class Remainder extends StatelessWidget {
  const Remainder({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 360,
            height: 100,
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
                    "Yuk Gunakan Remainder!",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pemberitahuan untuk pengeluran kamu yang \nhampir mencapai batas",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.topRight,
            child : Image.asset(
                "assets/images/logo_remainder.png",
                fit: BoxFit.contain,  ), 
          )  
        ],
      );
  
  }
}
