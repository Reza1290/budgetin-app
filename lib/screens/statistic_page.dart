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
  'Pengeluaranmu sangat rendah bulan ini. Pertahankan kebiasaan baik ini dan terus tabung lebih banyak!',
  'Pengeluaranmu cukup rendah. Bagus! Usahakan untuk menyimpan sebagian dari tabungan untuk investasi.',
  'Pengeluaranmu sedang. Cobalah untuk mengidentifikasi area di mana kamu bisa mengurangi pengeluaran.',
  'Pengeluaranmu agak tinggi bulan ini. Pertimbangkan untuk mengurangi pengeluaran yang tidak perlu.',
  'Pengeluaranmu sangat tinggi. Disarankan untuk membuat anggaran dan meninjau kembali pengeluaran rutin.',
];

String getAdvice(double persen) {
  if (persen >= 90) {
    return financialAdvices[4];
  } else if (persen >= 80) {
    return financialAdvices[3];
  } else if (persen >= 70) {
    return financialAdvices[2];
  } else if (persen >= 60) {
    return financialAdvices[1];
  } else if (persen >= 1) {
    return financialAdvices[0];
  } else {
    return 'Bulan ini tidak ada transaksi tercatat :(';
  }
}

class _StatisticPageState extends State<StatisticPage> {
  int _selectedIndex = DateTime.now().month - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: null,
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
                SizedBox(
                  height: 10,
                ),
                if (DateTime.now().month > _selectedIndex + 1)
                  Text("Kesimpulan",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                if (DateTime.now().month > _selectedIndex + 1)
                  FutureBuilder(
                      future: db!.prsentaseExpense(
                          DateTime(DateTime.now().year, _selectedIndex + 1)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Image.asset(
                                'assets/images/handling/white_loading.gif'),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          double persen = snapshot.data!;
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: BudgetinColors.biru20, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                getAdvice(persen),
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
                        return Text('');
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
