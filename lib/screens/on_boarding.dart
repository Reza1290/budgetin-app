import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/onboarding/button.dart';
import 'package:budgetin/widgets/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
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
                    InputMoney(fontSize: 12),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnBoardingScreen2()),
                    );
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
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
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
                    InputText(hintText: 'Masukkan nama kategori'),
                    SizedBox(height: 24),
                    InputMoney(fontSize: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCustom(
                        title: "Kembali",
                        blok: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ButtonCustom(
                        title: "Selanjutnya",
                        blok: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavbar()),
                          );
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
