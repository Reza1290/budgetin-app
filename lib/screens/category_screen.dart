import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/category/add_category_button.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:budgetin/widgets/forms/input_search.dart';
import 'package:budgetin/widgets/reusable/kategori_kosong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Stream<List<CategoryTotal>> getAllCategory() {
    return db!.sumExpenseByCategory(0);
  }

  Stream<List<CategoryTotal>> searchCategory(String keyword) {
    return db!.sumExpenseByCategorySearch(keyword);
  }

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isVisible2 = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_updateVisibility);
    _searchController.addListener(_updateVisibility);
  }

  void _updateVisibility() {
    setState(() {
      isVisible2 = _searchController.text.isEmpty || !_focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateVisibility);
    _searchController.removeListener(_updateVisibility);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BudgetinColors.hitamPutih10,
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
                      hintText: 'Cari Kategori bulan ini',
                      controller: _searchController,
                      focusNode: _focusNode,
                      showFilter: false,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    switchInCurve: Curves.easeInCirc,
                    child: Visibility(
                      key: Key(isVisible2.toString()),
                      visible: isVisible2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: AddCategoryButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<CategoryTotal>>(
                stream: _searchController.text.isEmpty
                    ? getAllCategory()
                    : searchCategory(_searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a more explicit loading indicator
                    return Image.asset(
                        'assets/images/handling/white_loading.gif');
                  } else if (snapshot.hasData) {
                    if (_focusNode.hasFocus && snapshot.data!.isEmpty) {
                      return Image.asset(
                          'assets/images/handling/white_loading.gif');
                    }
                    if (snapshot.data!.isEmpty)
                      return Center(
                        child: SvgPicture.asset(
                            height: MediaQuery.of(context).size.width * 0.4,
                            'assets/images/handling/not_found.svg'),
                      );

                    if (snapshot.data != null) {
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
                                createdAt: category.createdAt),
                            totalAmount: categories[index].totalAmount,
                            isHome: false,
                            // isReminder: true,
                          );
                        },
                      );
                    }
                  }

                  return Image.asset(
                      'assets/images/handling/white_loading.gif');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
