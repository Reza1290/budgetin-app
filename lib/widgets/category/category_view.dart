import 'package:budgetin/models/database.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
  Widget build(BuildContext context) {
    return Container();
  }
}
