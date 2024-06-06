import 'dart:math';

import 'package:budgetin/controller/category_controller.dart';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/utilities/them.dart';
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

                      int res = await db!.insertBudgetinVariable(
                          'monthNow', DateTime.now().toString());
                      // if (res > 0) {
                      //   print('MASUK SALDONYA' + res.toString());
                      // }

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
  final TextEditingController _nameController = TextEditingController();
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
                          InputText(
                            hintText: 'Masukkan nama kategori',
                            controller: _nameController,
                          ),
                          SizedBox(height: 24),
                          InputMoney(
                            focusNode: _focusDuit,
                            controller: _alokasiController,
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
                        width: MediaQuery.of(context).size.width / 2.8,
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
                        onPressed: () async {
                          if (_formOnboard2Key.currentState!.validate()) {
                            bool res = await CategoryController.insert(
                              _nameController.text,
                              'assets/icons/Lainnya.svg',
                              _alokasiController.text,
                            );

                            if (res) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavbar(
                                    initIndex: 0,
                                  ),
                                ),
                                (route) => false,
                              );
                            }
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


// Definisikan pesan-pesan yang mungkin
const List<String> savingsMessages = [
  'Yeyyy !!! Bulan lalu kamu berhasil menghemat {amount}',
  'Luar biasa! Kamu berhasil menabung {amount} bulan lalu',
  'Fantastis! Bulan lalu kamu mampu menghemat {amount}',
  'Selamat! Kamu menabung {amount} bulan lalu',
  'Bagus sekali! Bulan lalu kamu menghemat {amount}',
];

class OnBoardingScreen3 extends StatefulWidget {
  const OnBoardingScreen3({super.key});

  @override
  State<OnBoardingScreen3> createState() => _OnBoardingScreen3State();
}

class _OnBoardingScreen3State extends State<OnBoardingScreen3> {
  String getRandomMessage(int amount) {
    final random = Random();
    final randomIndex = random.nextInt(savingsMessages.length);
    return savingsMessages[randomIndex].replaceFirst('{amount}', amount.toString());
  }

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
                    FutureBuilder(
                      future: db!.remainingMoney(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Scaffold(
                            appBar: null,
                            backgroundColor: BudgetinColors.biru10,
                            body: Center(
                              child: Image.asset('assets/images/loading.gif'),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final randomMessage = getRandomMessage(snapshot.data!);
                          return OnBoardingContent(
                            image: 'assets/images/onBoarding3.svg',
                            title: randomMessage,
                            subtitle:
                                'Saat ini memaski bulan baru, Alokasi pada kategori akan di-reset. Apakah Kategori dan Saldo bulan ini sama dengan bulan lalu?',
                          );
                        } else {
                          return const SizedBox(
                            height: 12,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonCustom(
                      width: MediaQuery.of(context).size.width / 2.8,
                      title: "Tidak",
                      blok: false,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingScreen4()),
                          (route) => false,
                        );
                      },
                    ),
                    ButtonCustom(
                      width: MediaQuery.of(context).size.width / 4 * 2,
                      title: "Ya",
                      blok: true,
                      onPressed: () async {
                        bool res = await db!.copyPreviousCategoryAndSaldo();
                        if (res) {
                          await db!.insertBudgetinVariable(
                              'monthNow', DateTime.now().toString());
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavbar(
                                      initIndex: 0,
                                    )),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingScreen4 extends StatelessWidget {
  OnBoardingScreen4({super.key});

  final _formOnboard4Key = GlobalKey<FormState>();
  final TextEditingController _saldo2Controller = TextEditingController();

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
                      image: 'assets/images/onBoarding4.svg',
                      title: 'Kelola Keuanganmu Bulan Ini',
                      subtitle:
                          'Masukkan saldo atau pendapatanmu kembali untuk bulan ini!',
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formOnboard4Key,
                      child: InputMoney(
                          controller: _saldo2Controller, fontSize: 12),
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
                    if (_formOnboard4Key.currentState!.validate()) {
                      // int saldo =
                      int saldo =
                          TextCurrencyFormat.toInt(_saldo2Controller.text);
                      if (await db!.isSaldoLessThanAllocation(saldo)) {
                        await db!.createOrUpdateSaldo(saldo);
                      }

                      int res = await db!.insertBudgetinVariable(
                          'monthNow', DateTime.now().toString());

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavbar(),
                        ),
                        (route) => false,
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
