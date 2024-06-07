import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/faq/faq_content.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> faqList = [
      {
        "question": "Apa itu Saldo dan apa kegunaannya?",
        "answer":
            "Saldo adalah jumlah maksimum uang yang bisa Anda alokasikan ke berbagai kategori pengeluaran. Ini membantu Anda tetap teratur dan memastikan setiap kategori memiliki batasan yang jelas, sehingga memudahkan pengelolaan keuangan Anda."
      },
      {
        "question": "Bagaimana cara membuat alokasi berdasarkan kategori?",
        "answer":
            "Untuk membuat alokasi berdasarkan kategori, buka halaman Kategori dengan mengklik menu Kategori. Di sana, Anda bisa menambahkan dan mengatur alokasi dana untuk setiap kategori sesuai dengan kebutuhan Anda."
      },
      {
        "question": "Bagaimana cara membuat transaksi baru?",
        "answer":
            "Untuk membuat transaksi baru, cukup tekan tombol cepat (ADD) yang berada di tengah halaman utama. Tombol ini memungkinkan Anda menambahkan transaksi baru dengan mudah dan cepat."
      },
      {
        "question": "Apakah saya bisa mengubah transaksi yang sudah dilakukan?",
        "answer":
            "Ya, Anda bisa mengubah transaksi yang sudah dilakukan. Caranya, geser kartu Riwayat Transaksi ke kiri untuk menampilkan menu Edit dan Delete. Dengan ini, Anda bisa mengedit detail transaksi atau menghapusnya jika diperlukan."
      },
      {
        "question": "Apakah transaksi bulan lalu masih dapat terlihat?",
        "answer":
            "Ya, Anda masih dapat melihat transaksi dari bulan lalu. Riwayat transaksi bisa diakses hingga satu tahun ke belakang, sehingga Anda dapat dengan mudah memeriksa dan melacak pengeluaran sebelumnya."
      }
    ];

    return Scaffold(
      backgroundColor: BudgetinColors.hitamPutih10,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: null,
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        title: Text("FAQ"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 39.0, 24.0, 0),
                  child: Column(
                    children: [
                      ...List.generate(
                        faqList.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: FaqContent(
                              question: faqList[index]['question']!,
                              answer: faqList[index]['answer']!,
                            ),
                          );
                        },
                      ),
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
