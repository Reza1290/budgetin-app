import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/transaksi/add_transaksi.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Future<List<Category>> getAllCategory() {
    return db!.select(db!.categories).get();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        shape: const Border(
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
          style: TextStyle(
              fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: InputSearch(controller: _searchController),
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
                            itemCount: categories!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
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
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            categories[index].name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Belum ada Kategori, Silahkan buat terlebih dahulu."));
                        }
                      } else {
                        return Center(child: Text("Belum ada kategori"));
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
