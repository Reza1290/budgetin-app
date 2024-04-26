import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:budgetin/widgets/modal/modal_tambah_kategori.dart';
import 'package:flutter/material.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({super.key});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryTotal>>(
      stream: db!.sumExpenseByCategory(2),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryTotal>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Sekel(),
                SizedBox(
                  height: 18,
                ),
                Sekel()
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final List<CategoryTotal>? categories = snapshot.data;
        if (categories == null || categories.isEmpty) {
          return Center(
              child: Column(
            children: [
              Text('Silahkan Membuat Kategori Terlebih Dahulu'),
              Container(
                width: 60,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: BudgetinColors.biru30,
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      showModalTambahKategori(context, db!);
                    },
                    icon: Icon(Icons.add)),
              )
            ],
          ));
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              for (int index = 0;
                  index < categories.length && index < 2;
                  index++)
                Center(
                  child: CategoryCard(
                    category: Category(
                      id: categories[index].category.id,
                      name: categories[index].category.name.toString(),
                      icon: categories[index].category.icon.toString(),
                      total: categories[index].category.total,
                    ),
                    totalAmount: categories[index].totalAmount,
                    isHome: true,
                    // isReminder: true,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class Sekel extends StatelessWidget {
  const Sekel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // alignment: ,
            alignment: Alignment.topLeft,
            height: 16,
            width: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Colors.black.withOpacity(0.04),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.black.withOpacity(0.04),
                ),
                height: 14,
                width: MediaQuery.of(context).size.width * 4 / 6,
              ),
              SizedBox(
                width: 6,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.black.withOpacity(0.04),
                ),
                height: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}
