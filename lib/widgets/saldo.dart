import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/modal/show_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Saldo extends StatefulWidget {
  const Saldo({super.key});

  @override
  State<Saldo> createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  final TextEditingController _moneyController = TextEditingController();

  // void insertData() {
  //   insertCategory(CategoriesCompanion.insert(
  //       name: "name",
  //       total:
  //           int.parse(_moneyController.value.toString().replaceAll(',', ''))));
  // }

  int uang = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Category duit = await getCategory();
    // uang = duit.total;
    // print(uang);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 77, 148, 255),
                  Color.fromARGB(255, 229, 225, 249)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saldo",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white),
                ),
                const SizedBox(height: 7),
                InkWell(
                    onTap: () => showModal(
                        context,
                        "Tambah Saldo",
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        "Jumlah",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    InputMoney(
                                        controller: _moneyController,
                                        fontSize: 12)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        () {}),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            uang.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          size: 13,
                          color: Colors.white,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 77, 77),
                  Color.fromARGB(255, 255, 218, 247)
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Pengeluaran",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white),
                ),
                SizedBox(height: 7),
                Text(
                  "Rp 5.000.000",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
