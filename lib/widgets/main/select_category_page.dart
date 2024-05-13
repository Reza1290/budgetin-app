import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/category/add_category_button.dart';
import 'package:budgetin/widgets/main/select_category_card.dart';
import 'package:budgetin/widgets/transaksi/create_update_transaksi.dart';
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
    _controller = AnimationController(vsync: this);
  }

  void _updateVisibility() {
    setState(() {
      isVisible2 = _searchController.text.isEmpty && !_focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateVisibility);
    _searchController.removeListener(_updateVisibility);
    _searchController.dispose();
    _focusNode.dispose();
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
              child: StreamBuilder<List<Category>>(
                  stream: _searchController.text.isEmpty
                      ? db!.getAllCategoryByMonthAndYear()
                      : db!.getAllCategoryByMonthAndYearSearch(
                          _searchController.text),
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
                                  "Silahkan buat Kategori terlebih dahulu."));
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
