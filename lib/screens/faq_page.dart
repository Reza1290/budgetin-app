import 'package:budgetin/widgets/faq/faq_content.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        leadingWidth: 100,
        title: Text("FAQ"),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 39.0, 24.0, 0),
                  child: Column(
                    children: [
                      FaqContent(
                        question: 'Apa Guna Saldo?',
                        answer:
                            'Saldo adalah jumlah Maksimum yang dapat dialokasikan ke beberapa kategori.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question:
                            'Bagaimana Cara untuk membuat alokasi berdasarkan Kategori?',
                        answer:
                            'Buatlah melalui halaman Kategori, anda dapat mengakesnya pada halaman utama Kategori, klik Lainnya.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question: 'Bagaimana Cara untuk membuat Transaksi?',
                        answer:
                            'Tekan Quick Button (ADD) pada tengah Halaman. ',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question:
                            'Apakah saya bisa mengubah Transaksi yang sudah saya Lakukan?',
                        answer:
                            'Slide ke kiri kartu Riwayat Transaksi untuk menampilkan menu Edit dan Delete.',
                      ),
                      SizedBox(height: 15),
                      // FaqContent(
                      //   question: 'How to manage budget?',
                      //   answer:
                      //       'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                      // ),
                      // SizedBox(height: 15),
                      // FaqContent(
                      //   question: 'How to manage budget?',
                      //   answer:
                      //       'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                      // ),
                      // SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
