import 'dart:async';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/modal/show_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaldoWidget extends StatefulWidget {
  const SaldoWidget({super.key});

  @override
  State<SaldoWidget> createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<SaldoWidget> {
  final TextEditingController _moneyController = TextEditingController();
  int _saldo = 0;

  final Widget svg = SvgPicture.asset('assets/images/maskot.svg');

  // AppDb _db = AppDb();
  // Future<int> totalExpense() async {
  //   return await db!.totalExpense().whenComplete(() {
  //     // db.close();
  //   }); // Tambahkan await di sini
  // }

  void simpanSaldo(int sal, BuildContext context) async {
    int sum = await db!.sumUsedSaldo();
    if (sum > sal) {
      // debugPrint("teteh" + await db!.sumUsedSaldo().toString());
      String alokasi = TextCurrencyFormat.format(sum.toString());
      showFailedAlert(context,
          "Perbaiki Alokasi, karena Saldo teralokasi lebih besar dari saldo yang dimasukkan. $alokasi");
    } else {
      await db!.createOrUpdateSaldo(sal);
    }
  }

  Stream<Saldo> saldoUpdate() {
    final controller = StreamController<Saldo>();

    db!.watchFirstSaldo().listen((saldo) {
      // Update the _moneyController.text when a new saldo is emitted
      _moneyController.text = saldo.saldo.toString();

      // Add the new saldo to the stream
      controller.add(saldo);
    });

    return controller.stream;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _moneyController.text = _saldo.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -67,
          right: 0,
          child: svg,
          // width: MediaQuery.of(context).size.width,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromARGB(255, 77, 148, 255),
                      // Color.fromARGB(255, 229, 225, 249)
                      Color(0xff4979C2),
                      Color(0xff4D9FFF)
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Saldo",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 7),
                    InkWell(
                        onTap: () => showModal(
                                context,
                                "Ubah Saldo",
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 12.0),
                                              child: Text(
                                                HumanReadableDateFormatter
                                                    .dateNowFormatter(
                                                        DateTime.now()),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            InputMoney(
                                                controller: _moneyController,
                                                fontSize: 12)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ), () {
                              simpanSaldo(
                                  int.parse(_moneyController.text
                                      .replaceAll('.', '')),
                                  context);
                            }),
                        child: Row(
                          children: [
                            Expanded(
                              child: StreamBuilder(
                                stream: saldoUpdate(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    return Text(
                                      TextCurrencyFormat.format(
                                          snapshot.data!.saldo.toString()),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      'Rp. 0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 13,
                              color: Colors.white,
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromARGB(255, 255, 218, 247)
                      Color(0xffC2497C),
                      Color.fromARGB(255, 255, 77, 77),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Pengeluaran",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    SizedBox(height: 7),
                    StreamBuilder<int>(
                        stream: db!.totalExpense(),
                        builder: (context, snapshot) {
                          int expense = snapshot.data ?? 0;

                          return Text(
                            TextCurrencyFormat.format(expense.toString()),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis),
                          );
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
