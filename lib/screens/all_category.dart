import 'dart:async';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/detail_kategori_page.dart';
import 'package:budgetin/widgets/modal_tambah_kategori.dart';
import 'package:flutter/material.dart';

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

  Future<void> insert(String name, int total) async {
    await database
        .into(database.categories)
        .insertReturning(CategoriesCompanion.insert(name: name, total: total));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Nunito'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text("Kategori Transaksi"),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  showModalTambahKategori(context);
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
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailKategoriPage())),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.blue.shade100,
                          border: Border.all(color: Colors.grey.shade200)),
                      width: 54,
                      height: 54,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/1160/1160908.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Makanan",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.amber,
                                      minHeight: 16,
                                      value: prsentase1 / 100,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: const Text(
                                        'Rp. 120000',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${prsentase1.toString()}%",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
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
