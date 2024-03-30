import 'package:budgetin/screens/all_category.dart';
import 'package:budgetin/widgets/category_home.dart';
import 'package:budgetin/widgets/remainder.dart';
import 'package:budgetin/widgets/saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: SafeArea(
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
                Text("Waktunya Catat Keuangan Kamu Hari Ini."),
                SizedBox(
                  height: 20,
                ),
                Saldo(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kategori Transaksi",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllCategory()));
                        },
                        child: Text(
                          "lainnnya",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        )),
                  ],
                ),
                CategoryHome(),
                SizedBox(
                  height: 30,
                ),
                Remainder()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
