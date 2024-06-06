import 'package:budgetin/main.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/statistic/statistic_bar.dart';
import 'package:budgetin/widgets/statistic/statistic_circular.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

const List<String> financialAdvices = [
  'Pengeluaranmu sangat rendah bulan lalu. Pertahankan kebiasaan baik ini dan terus tabung lebih banyak!',
  'Pengeluaranmu cukup rendah. Bagus! Usahakan untuk menyimpan sebagian dari tabungan untuk investasi.',
  'Pengeluaranmu sedang. Cobalah untuk mengidentifikasi area di mana kamu bisa mengurangi pengeluaran.',
  'Pengeluaranmu agak tinggi bulan lalu. Pertimbangkan untuk mengurangi pengeluaran yang tidak perlu.',
  'Pengeluaranmu sangat tinggi. Disarankan untuk membuat anggaran dan meninjau kembali pengeluaran rutin.',
];

String getAdvice(double persen){
  if(persen >= 90){
    return financialAdvices[4];
  }else if(persen >= 80){
    return financialAdvices[3];
  }else if(persen >= 70 ){
    return financialAdvices[2];
  }else if(persen >= 60){
    return financialAdvices[1];
  }else{
    return financialAdvices[0];
  }
}

class _StatisticPageState extends State<StatisticPage> {
  int _selectedIndex = DateTime.now().month - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        leadingWidth: 100,
        title: const Text("Statistik"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticBar(
                  bulan: _selectedIndex,
                  callback: _setBulan,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Diagram Kategori",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: BudgetinColors.biru20, width: 2),
                  ),
                  child: StatisticCircular(
                    bulan: _selectedIndex,
                  ),
                ),
                FutureBuilder(
                    future: db!.prsentaseExpense(),
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
                        double persen = snapshot.data!;
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[100], // Warna latar belakang
                            borderRadius: BorderRadius.circular(
                                10.0), // Bentuk rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Warna shadow
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Offset dari shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              advice,
                              style: TextStyle(
                                fontSize: 18.0, // Ukuran font
                                fontWeight: FontWeight.bold, // Ketebalan font
                                color: Colors.black, // Warna font
                              ),
                              textAlign:
                                  TextAlign.center, // Posisi teks di tengah
                            ),
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setBulan(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
