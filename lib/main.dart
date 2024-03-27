import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budgetin',
      // Set Raleway as the default app font.
      theme: ThemeData(fontFamily: 'Nunito'),
      home: const RiwayatTransaksiPage(),
    );
  }
}

class BudgetinHomePage extends StatelessWidget {
  const BudgetinHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('a'),
      ),
    );
  }
}
