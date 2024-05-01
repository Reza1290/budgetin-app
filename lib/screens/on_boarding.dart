import 'package:budgetin/main.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/onboarding/button.dart';
import 'package:budgetin/widgets/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen1 extends StatelessWidget {
  OnBoardingScreen1({Key? key});
  final _formOnboardKey = GlobalKey<FormState>();
  final TextEditingController _saldoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    OnBoardingContent(
                      image: 'assets/images/onBoarding1.svg',
                      title: 'Kelola Uangmu',
                      subtitle:
                          'Yuk, mulai dengan memasukkan saldo atau pendapatanmu bulan ini!',
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formOnboardKey,
                      child: InputMoney(
                          controller: _saldoController, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ButtonCustom(
                  title: "Selanjutnya",
                  blok: true,
                  onPressed: () async {
                    if (_formOnboardKey.currentState!.validate()) {
                      // int saldo =
                      int saldo =
                          TextCurrencyFormat.toInt(_saldoController.text);
                      if (await db!.isSaldoLessThanAllocation(saldo)) {
                        await db!.createOrUpdateSaldo(saldo);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardingScreen2()),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingScreen2 extends StatelessWidget {
  OnBoardingScreen2({super.key});
  final _formOnboard2Key = GlobalKey<FormState>();
  final FocusNode _focusDuit = FocusNode();
  final TextEditingController _alokasiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    OnBoardingContent(
                      image: 'assets/images/onBoarding2.svg',
                      title: 'Atur Kategori Keuanganmu',
                      subtitle:
                          'Mengategorikan pengeluaranmu akan lebih memudahkan pengelolaan keuangan.Yuk, buat kategori sesuai kebutuhanmu!',
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formOnboard2Key,
                      child: Column(
                        children: [
                          InputText(hintText: 'Masukkan nama kategori'),
                          SizedBox(height: 24),
                          InputMoney(
                            focusNode: _focusDuit,
                            fontSize: 12,
                            hintText:
                                'Masukkan alokasi dana untuk kategori ini',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                  // width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCustom(
                        width: MediaQuery.of(context).size.width / 3,
                        title: "Kembali",
                        blok: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ButtonCustom(
                        width: MediaQuery.of(context).size.width / 4 * 2,
                        title: "Selanjutnya",
                        blok: true,
                        onPressed: () {
                          if (_formOnboard2Key.currentState!.validate()) {
                            int saldo = TextCurrencyFormat.toInt(
                                _alokasiController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavbar()),
                            );
                          } else {
                            _focusDuit.requestFocus();
                          }
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
