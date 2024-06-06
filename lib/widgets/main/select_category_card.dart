import 'package:budgetin/models/database.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/transaksi/create_update_transaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCategoryCard extends StatelessWidget {
  final Category category;

  const SelectCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Widget icon = SvgPicture.asset(
        category.icon == '' ? 'assets/icons/Lainnya.svg' : category.icon);
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              CreateUpdateTransaksiPage(categoryId: category.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Row(
          children: [
            Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: BudgetinColors.biru20,
                ),
                child: icon),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12.0),
                child: Text(
                  category.name,
                  style: TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      color: textPrimary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
