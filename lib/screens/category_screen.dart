import 'dart:async';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category/add_category_button.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:budgetin/widgets/modal/modal_tambah_kategori.dart';
import 'package:budgetin/widgets/modal/sheet_create_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        leading: Container(),
        title: Text("Kategori Transaksi"),
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                      showFilter: true,
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
              child: StreamBuilder<List<CategoryTotal>>(
                stream: db!.sumExpenseByCategory(0),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CategoryTotal>> snapshot) {
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
                    final List<CategoryTotal>? categories = snapshot.data;
                    return ListView.builder(
                      itemCount: categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        Category category = categories![index].category;
                        return CategoryCard(
                          category: Category(
                            id: category.id,
                            name: category.name.toString(),
                            icon: category.icon.toString(),
                            total: category.total,
                          ),
                          totalAmount: categories[index].totalAmount,
                          isHome: false,
                          // isReminder: true,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
