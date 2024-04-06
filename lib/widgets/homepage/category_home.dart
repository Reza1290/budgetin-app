import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category/category_card.dart';
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
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final List<CategoryTotal>? categories = snapshot.data;
        if (categories == null || categories.isEmpty) {
          return Text('No categories found');
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
