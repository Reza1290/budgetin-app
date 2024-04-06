import 'package:budgetin/providers/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RiwayatTransaksi extends StatelessWidget {
  final String title;
  final String tanggal;
  final String money;
  final String icon;

  const RiwayatTransaksi(
      {super.key,
      required this.title,
      required this.tanggal,
      required this.money,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.7),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        offset: const Offset(0, 1), // Bayangan ke bawah
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, -1), // Bayangan ke atas
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Image.asset(
                      icon == '' ? 'assets/icons/lainnya.png' : icon,
                      width: 29.0,
                      height: 29.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Container(
                height: 55.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, -1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            tanggal,
                            style: const TextStyle(
                                fontSize: 8.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: 90,
                        child: Text(
                          '- ' + TextCurrencyFormat.format(money),
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
