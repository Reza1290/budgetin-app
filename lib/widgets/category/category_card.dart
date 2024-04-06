import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/screens/detail_kategori_page.dart';
import 'package:flutter/material.dart';
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
    bool isReminder = totalAmount / category.total > 0.8;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailKategoriPage(
                categoryId: category.id,
              ),
            ));
      },

      hoverColor: Colors.transparent,
      // padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
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
                  child: Image.asset(
                    category.icon == ''
                        ? 'assets/icons/lainnya.png'
                        : category.icon,
                  ),
                ),
              ),
        title: Text(
          category.name.toString(),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
                          color: Colors.amber,
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
                                  fontSize: 10, fontWeight: FontWeight.w600),
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
                            'Pengeluaran mendekati batas maksimal.',
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
