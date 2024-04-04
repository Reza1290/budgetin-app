import 'package:budgetin/models/database.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.category,
      this.isHome = true,
      this.isReminder = false})
      : super(key: key);

  final Category category;
  final bool isHome;
  final bool isReminder;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'assets/icons/lainnya.png',
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
                          value: 40 / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 10.0),
                            child: const Text(
                              'Rp. 120000',
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
                    "2%",
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
                          Text(
                            'Pengeluaran anda hampir mencapai maksimum',
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
