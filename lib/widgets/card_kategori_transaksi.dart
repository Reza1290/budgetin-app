import 'package:flutter/material.dart';

class CardKategoriTransaksi extends StatelessWidget {
  const CardKategoriTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 342.0,
          height: 167.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 17.0,
              ),
              Container(
                width: 100.0,
                height: 98.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF2F2F2),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22.0, 22.0, 24.0, 24.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1160/1160908.png',
                    width: 55.0,
                    height: 53.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                  const Flexible(
                    child: Text(
                      'Olahraga',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    // CONTOH PEMANGGILAN ALERT 
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
