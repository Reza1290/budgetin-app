import 'package:budgetin/main.dart';
import 'package:budgetin/models/saldo_data.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:flutter/material.dart';

Future<void> showModalSaldo(BuildContext context) {
  TextEditingController moneyController = TextEditingController();
  FocusNode moneyFocus = FocusNode(canRequestFocus: true);
  moneyFocus.requestFocus();
  return showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: FutureBuilder<SaldoData>(
                      future: db!.getDataSaldo(),
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: BudgetinColors.merah10,
                                        width: 3)),
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    'Teralokasi ${snapshot.connectionState != ConnectionState.waiting ? snapshot.hasData && snapshot.data != null ? TextCurrencyFormat.format(snapshot.data!.teralokasi.toString()) : 'Rp0' : 'Rp0'}',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: BudgetinColors.merah50),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: const Text(
                                "Input Saldo",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                            InputMoney(
                              fontSize: 13,
                              controller: moneyController,
                              focusNode: moneyFocus,
                              hintText:
                                  '${snapshot.connectionState != ConnectionState.waiting ? snapshot.hasData && snapshot.data != null ? snapshot.data!.saldo : 0 : 0}',
                            ),
                          ],
                        );
                      }),
                )
              ],
            );
          },
        ),
      );
    },
  );
}
