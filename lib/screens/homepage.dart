import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/category_screen.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/homepage/kategori_transaksi/category_home.dart';
import 'package:budgetin/widgets/homepage/saldo.dart';
import 'package:budgetin/widgets/homepage/reminder.dart';
import 'package:budgetin/widgets/homepage/saldo_section.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  final VoidCallback changeTab;
  const HomePage({super.key, required this.changeTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<TransactionWithCategory>> getAllTransactions() {
    return db!.getTransactionWithCategoryLimit(4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose-
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: BudgetinColors.biru40,
                        ),
                      ),
                      Text(
                        "Waktunya Catat Keuangan Kamu Hari Ini.",
                        style: TextStyle(
                          fontSize: 12,
                          color: BudgetinColors.hitamPutih100,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: SaldoSection(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kategori Transaksi",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: BudgetinColors.hitamPutih100,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            widget.changeTab();
                          },
                          child: Text(
                            "Lainnnya",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: BudgetinColors.biru40),
                          )),
                    ],
                  ),
                ),
                CategoryHome(),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Reminder(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24),
                  child: Text(
                    "Riwayat Transaksi",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: BudgetinColors.hitamPutih100),
                  ),
                ),
                RiwayatTransaksiList(
                  getAllTransactions: () => getAllTransactions(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
