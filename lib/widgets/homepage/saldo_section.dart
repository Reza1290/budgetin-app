import 'dart:async';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/modal/show_modal.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaldoSection extends StatefulWidget {
  const SaldoSection({super.key});

  @override
  State<SaldoSection> createState() => _SaldoSectionState();
}

class _SaldoSectionState extends State<SaldoSection> {
  // final TextEditingController _moneyController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/images/maskot.svg');

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          height: 170,
          top: -100,
          right: -50,
          child: svg,
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
                    colors: [Color(0xff4979C2), Color(0xff4D9FFF)],
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
                    StreamBuilder<int>(
                      stream: db!.watchUsedSaldo(),
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
                      },
                    )
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
                      stream: db!.totalExpenseMonth(),
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
                      },
                    )
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
