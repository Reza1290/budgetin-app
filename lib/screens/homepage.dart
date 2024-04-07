import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/all_category.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:budgetin/widgets/homepage/category_home.dart';
import 'package:budgetin/widgets/remainder.dart';
import 'package:budgetin/widgets/homepage/saldo.dart';
import 'package:budgetin/widgets/transaksi/riwayat_transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    // TODO: implement dispose
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang!",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 29, 119, 255)),
                      ),
                      Text(
                        "Waktunya Catat Keuangan Kamu Hari Ini.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Saldo(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kategori Transaksi",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllCategory()));
                          },
                          child: Text(
                            "Lainnnya",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PrimaryColor.shade400),
                          )),
                    ],
                  ),
                ),
                CategoryHome(),

                // CategoryCard(
                //   category: Category(
                //     id: 2,
                //     name: 'Makanan',
                //     icon: 'assets/icons/lainnya.png',
                //     total: 123,
                //   ),
                //   totalAmount: 40,
                //   isHome: true,
                // ),
                // CategoryCard(
                //   category: Category(
                //     id: 2,
                //     name: 'Makanan',
                //     icon: 'assets/icons/lainnya.png',
                //     total: 123,
                //   ),
                //   totalAmount: 40,
                //   isHome: true,

                // ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Remainder(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24),
                  child: const Text(
                    "Riwayat Transaksi",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
