import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/screens/detail_kategori_page.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.isHome = true,
    required this.totalAmount,
  });
  final int totalAmount;
  final Category category;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    Widget icon = SvgPicture.asset(
        category.icon == '' ? 'assets/icons/Lainnya.svg' : category.icon);
    bool isReminder = totalAmount / category.total > 0.8;
    Color color = isReminder
        ? merahWarn
        : totalAmount / category.total > 0.5
            ? kuningWarn
            : hijauWarn;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailKategoriPage(
                  category: category, totalAmount: totalAmount),
            ));
      },

      hoverColor: Colors.transparent,
      // padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24),
        isThreeLine: isReminder,
        leading: isHome
            ? null
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.grey.shade200)),
                width: 54,
                height: 54,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: icon,
                ),
              ),
        title: Text(
          category.name
              .replaceFirst(category.name[0], category.name[0].toUpperCase()),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              overflow: TextOverflow.ellipsis),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(100),
                          color: color,
                          minHeight: 17,
                          value: totalAmount / category.total,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              TextCurrencyFormat.format(totalAmount.toString()),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isReminder ? Colors.white : hitam100),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    (NumberFormat.percentPattern('id').format(double.parse(
                            (totalAmount / category.total).toStringAsFixed(3))))
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              isReminder
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: Colors.redAccent,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            (totalAmount / category.total > 0.98)
                                ? 'Batas Maksimum Tercapai.'
                                : 'Pengeluaran mendekati batas maksimal.',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                          )
                        ],
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
