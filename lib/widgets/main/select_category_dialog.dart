import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/add_transaksi.dart';
import 'package:budgetin/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectCategoryDialog extends StatefulWidget {
  const SelectCategoryDialog({super.key});

  @override
  State<SelectCategoryDialog> createState() => _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late AppDb db;

  Future<List<Category>> getAllCategory() {
    return db!.select(db!.categories).get();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // db = AppDb();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        shape: Border(
            bottom: BorderSide(
          color: Colors.black12,
        )),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'Pilih Kategori',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: SearchInput(controller: _searchController),
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                  future: getAllCategory(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshots.hasData) {
                        if (snapshots.data!.length > 0) {
                          final List<Category>? categories = snapshots.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                categories!.length, // Menggunakan panjang data
                            itemBuilder: (context, index) {
                              return InkWell(
                                // Menambahkan return di sini
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTransaksi(
                                        categoryId: categories[index].id),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 24.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.shade200,
                                        ),
                                        child: Image.asset(
                                          categories[index].icon == ''
                                              ? 'assets/icons/lainnya.png'
                                              : categories[index].icon,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          categories[index]
                                              .name, // Mengambil nama kategori
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Text("Kategori Belum ada");
                        }
                      } else {
                        return Text("Belum ada kategori");
                      }
                    }
                  }),
            )
          ],
        ),
      ),

      // body: Sing,
    );
  }
}
