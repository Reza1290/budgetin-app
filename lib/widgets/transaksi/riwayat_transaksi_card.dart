import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiwayatTransaksiCard extends StatelessWidget {
  final String title;
  final String tanggal;
  final String money;
  final String icon;

  const RiwayatTransaksiCard(
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
                    color: PrimaryColor.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    boxShadow: [
                      BoxShadow(
                        color: PrimaryColor.shade200,
                        spreadRadius: 1,
                        offset: const Offset(0, 1), // Bayangan ke bawah
                      ),
                      BoxShadow(
                        color: PrimaryColor.shade100,
                        offset: const Offset(0, -1), // Bayangan ke atas
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: SvgPicture.asset(
                      icon == '' ? 'assets/icons/Lainnya.svg' : icon,
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
                      color: PrimaryColor.shade200,
                      spreadRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                    BoxShadow(
                      color: PrimaryColor.shade100,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title.replaceFirst(
                                  title[0], title[0].toUpperCase()),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              HumanReadableDateFormatter.format(
                                  DateTime.parse(tanggal)),
                              style: const TextStyle(
                                  fontSize: 8.0,
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 1 / 4,
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
