import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  final AppDb database = AppDb();
  List<Category> listCategory = [];
  int widthBar = 60;
  int prsentase1 = 30;
  int prsentase2 = 50;
  int prsentase3 = 90;

  // Future<List<Category>> getAllCategory() async {
  //   // return await database.getAllCategoryRepo();
  // }

  Future<void> insert(String name, int total) async {
    await database
        .into(database.categories)
        .insertReturning(CategoriesCompanion.insert(name: name, total: total));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kategori Transaksi"),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('Tambah Kategori')),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama Kategori"),
                            TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "ex makanan",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Jumlah"),
                            TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly // Hanya mengizinkan input angka
                              ],
                              decoration: InputDecoration(
                                hintText: "100000",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FractionallySizedBox(
                            widthFactor:
                                1.0, // Menetapkan lebar Container sebesar setengah layar
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "Simpan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.add_circle, color: Colors.blue[400]),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Tambah Kategori",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue[400]),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Row(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1160/1160908.png',
                    width: 29.0,
                    height: 29.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Makanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100 *
                                        prsentase1 /
                                        100,
                                    height: 15,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "${prsentase1.toString()}%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: prsentase1 <= 40
                                            ? Colors.green[400]
                                            : (prsentase1 > 40 &&
                                                    prsentase1 <= 70)
                                                ? Colors.yellow[400]
                                                : Colors.red[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                ],
                              ),
                              prsentase1 >= 70 ? Text("Warning", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w400),) : Container()
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${prsentase1.toString()}%",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Row(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1160/1160908.png',
                    width: 29.0,
                    height: 29.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Makanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100 *
                                        prsentase2 /
                                        100,
                                    height: 15,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "${prsentase2.toString()}%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: prsentase2 <= 40
                                            ? Colors.green[400]
                                            : (prsentase2 > 40 &&
                                                    prsentase2 <= 70)
                                                ? Colors.yellow[400]
                                                : Colors.red[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                ],
                              ),
                              prsentase2 >= 70 ? Text("Warningggg", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w400),) : Container()
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${prsentase1.toString()}%",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Row(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1160/1160908.png',
                    width: 29.0,
                    height: 29.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Makanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        widthBar /
                                        100 *
                                        prsentase3 /
                                        100,
                                    height: 15,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "${prsentase3.toString()}%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: prsentase3 <= 40
                                            ? Colors.green[400]
                                            : (prsentase3 > 40 &&
                                                    prsentase3 <= 70)
                                                ? Colors.yellow[400]
                                                : Colors.red[400],
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                ],
                              ),
                              prsentase3 >= 70 ? Text("Warning", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w400),) : Container()
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${prsentase1.toString()}%",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

 
//  showCupertinoModalPopup(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Center(
//                           child: Container(
//                             width: 325,
//                             height: 200,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Tambah Kategori",
//                                   style: TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.w800),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(15.0),
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(10)))),
//                                       ),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {},
//                                       child: Text("Simpan"),
//                                       style: ButtonStyle(
//                                           backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                                           fixedSize: MaterialStateProperty.all<Size>(Size(266, 54))
//                                           ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );