import 'dart:async';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/modal/modal_bagikan.dart';
import 'package:budgetin/widgets/modal/modal_saldo.dart';
import 'package:budgetin/widgets/modal/show_modal.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:flutter/material.dart';

class SaldoCard extends StatefulWidget {
  const SaldoCard({super.key});

  @override
  State<SaldoCard> createState() => _SaldoCardState();
}

class _SaldoCardState extends State<SaldoCard> {
  late TextEditingController _moneyController =
      TextEditingController(text: '0');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width,
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText("Saldo Bulan Ini", 16, FontWeight.w700, putih30),
          SizedBox(height: 10),
          StreamBuilder<Saldo>(
              stream: db!.watchSaldoMonthNow(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildText("Rp0", 26, FontWeight.w800, putih30);
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return _buildText(
                          TextCurrencyFormat.format(
                              snapshot.data!.saldo.toString()),
                          26,
                          FontWeight.w800,
                          putih30);
                    } else {
                      return _buildText("Rp0", 26, FontWeight.w800, putih30);
                    }
                  } else {
                    return _buildText("Rp0", 26, FontWeight.w800, putih30);
                  }
                }
              }),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 5.0,
            color: putih30,
          ),
          SizedBox(
            height: 10.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => showModalSaldo(context),
                  style: TextButton.styleFrom(
                    backgroundColor: BudgetinColors.hitamPutih10,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Mengatur radius menjadi 5
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: BudgetinColors.biru90,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Ubah Saldo",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: BudgetinColors.biru90),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showModalBagikan(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: BudgetinColors.hitamPutih10,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Mengatur radius menjadi 5
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 10), // Mengatur padding menjadi 0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: BudgetinColors.biru90,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Bagikan",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: BudgetinColors.biru90))
                    ],
                  ),
                ),
              )
            ],
          )

          // StreamBuilder<int>(
          //     stream: db!.watchUsedSaldo(),
          //     builder: (context, snapshot) {
          //       String saldo = "Rp. 0";
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         saldo = "Rp. 0";
          //       } else {
          //         if (snapshot.hasData) {
          //           if (snapshot.data != null) {
          //             saldo =
          //                 TextCurrencyFormat.format(snapshot.data.toString());
          //           }
          //         } else {
          //           saldo = "Rp. 0";
          //         }
          //       }
          //       return ContainerSaldo(
          //           saldo: saldo,
          //           textColour: merah60,
          //           bgColour: merah10,
          //           icon: Icons.arrow_upward_rounded);
          //     }),
        ],
      ),
    );
  }

  void simpanSaldo(int sal, BuildContext context) async {
    int sum = await db!.sumUsedSaldo();
    if (sum > sal) {
      // debugPrint("teteh" + await db!.sumUsedSaldo().toString());
      String alokasi = TextCurrencyFormat.format(sum.toString());
      showFailedAlert(context,
          "Perbaiki Alokasi, karena Saldo teralokasi lebih besar dari saldo yang dimasukkan. $alokasi");
    } else {
      await db!.createOrUpdateSaldo(sal);
      Navigator.pop(context);
      showSuccessAlert(context, "Berhasil");
    }
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
      // width: MediaQuery.of(context).size.width / 2,
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
          Expanded(
            child: _buildText(saldo, 12, FontWeight.w600, textColour),
          )
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
        overflow: TextOverflow.ellipsis),
  );
}
