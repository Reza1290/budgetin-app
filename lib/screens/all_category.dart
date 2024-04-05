import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/modal_tambah_kategori.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  late AppDb _db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _db.close();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
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
              showModalTambahKategori(context, _db);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.blue[400]),
                  SizedBox(width: 20),
                  Text(
                    "Tambah Kategori",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: _db.allCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                debugPrint(snapshot.data.toString());

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a more explicit loading indicator
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Loading categories...'),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: snapshot.hasData
                              ? Text('Muat Ulang..')
                              : Text('Buat Kategori Terlebih Dahulu'),
                        ),
                      ],
                    ),
                  );
                } else {
                  final List<Category>? categories = snapshot.data;
                  debugPrint(categories.toString());
                  return ListView.builder(
                    itemCount: categories?.length ?? 0,
                    itemBuilder: (context, index) {
                      Category category = categories![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 4.0),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blue.shade100,
                                border:
                                    Border.all(color: Colors.grey.shade200)),
                            width: 54,
                            height: 54,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                'assets/icons/lainnya.png',
                              ),
                            ),
                          ),
                          title: Text(
                            category.name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Stack(
                                children: [
                                  LinearProgressIndicator(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.amber,
                                    minHeight: 16,
                                    value: 40 / 100,
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
                                "2%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
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
/*

GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailKategoriPage())),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
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
            ),
 */
