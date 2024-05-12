import 'package:budgetin/controller/saldo_controller.dart';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/saldo_data.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:flutter/material.dart';

Future<void> showModalSaldo(BuildContext context) {
  TextEditingController moneyController = TextEditingController();
  FocusNode moneyFocus = FocusNode(canRequestFocus: true);
  FocusNode keyboardFocus = FocusNode(canRequestFocus: true);
  final formKeySaldo = GlobalKey<FormState>();
  final saldoKey = GlobalKey<FormState>();

  moneyFocus.requestFocus();
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24),
            child: SingleChildScrollView(
              child: FutureBuilder<SaldoData>(
                  future: db!.getDataSaldo(),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: BudgetinColors.merah10, width: 3)),
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Text(
                                'Teralokasi ${snapshot.connectionState != ConnectionState.waiting ? snapshot.hasData && snapshot.data != null ? TextCurrencyFormat.format(snapshot.data!.teralokasi.toString()) : 'Rp0' : 'Rp0'}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(color: BudgetinColors.merah50),
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
                        Form(
                          key: formKeySaldo,
                          child: InputMoney(
                            key: saldoKey,
                            formKey: formKeySaldo,
                            fontSize: 13,
                            controller: moneyController,
                            focusNode: moneyFocus,
                            errorText: 'Pastikan Diatas Teralokasi',
                            hintText:
                                '${snapshot.connectionState != ConnectionState.waiting ? snapshot.hasData && snapshot.data != null ? snapshot.data!.saldo : 0 : 0}',
                            onEditingComplete: () async {
                              if (formKeySaldo.currentState!.validate()) {
                                bool a = await SaldoController.simpanSaldo(
                                    int.parse(moneyController.text
                                        .replaceAll('.', '')));

                                if (a) {
                                  // print('a');
                                  Navigator.pop(context);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      );
    },
  );
}
