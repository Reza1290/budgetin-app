import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category/add_category_button.dart';
import 'package:budgetin/widgets/main/select_category_card.dart';
import 'package:budgetin/widgets/transaksi/add_transaksi.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: InputSearch(
                      controller: _searchController,
                      showFilter: false,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: AddCategoryButton(),
                  ),
                ],
              ),
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
                              return SelectCategoryCard(
                                  category: categories[index]);
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
