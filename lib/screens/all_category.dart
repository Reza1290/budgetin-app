import 'dart:async';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category/category_card.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // db.close();
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
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: Text("Kategori Transaksi"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                showModalTambahKategori(context, db!);
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
