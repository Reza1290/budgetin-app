import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/sheet_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget svg = SvgPicture.asset('assets/icons/Plus.svg');
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => showSheetCategory(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: BudgetinColors.biru40)),
            borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: svg,
            ),
            Text(
              'Tambahkan Kategori Baru',
              style: TextStyle(
                  color: BudgetinColors.biru80,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
