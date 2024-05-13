import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_insert.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:flutter/material.dart';
import 'package:budgetin/utilities/them.dart';

class BudgetStatusCard extends StatelessWidget {
  final int categoryId;
  final bool isEditPage;
  final int temp;
  const BudgetStatusCard({
    Key? key,
    required this.categoryId,
    required this.isEditPage,
    required this.temp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 3, color: BudgetinColors.merah10),
        color: BudgetinColors.merah10,
      ),
      child: StreamBuilder<TransactionInsert>(
          stream: db!.streamCategoryById(categoryId, isEditPage, temp: temp),
          builder: (context, snapshot) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: BudgetinColors.hitamPutih10,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? ''
                              : (snapshot.hasData && snapshot.data != null)
                                  ? snapshot.data!.category.name
                                  : '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' masih mencukupi, ya!',
                        ),
                      ],
                      text: 'Pastikan saldo alokasi untuk kategori ',
                      style: TextStyle(
                        color: BudgetinColors.merah50,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: BudgetinColors.merah50,
                            ),
                            child: Icon(
                              Icons.attach_money_rounded,
                              color: BudgetinColors.hitamPutih10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              'Uang Sisa',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: BudgetinColors.merah50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Text(
                          (snapshot.connectionState == ConnectionState.waiting)
                              ? 'Rp0'
                              : (snapshot.hasData && snapshot.data != null)
                                  ? TextCurrencyFormat.format(
                                      snapshot.data!.total.toString())
                                  : 'Rp0',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: BudgetinColors.merah50,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            // if () {
            // } else if (snapshot.hasData && snapshot.data != null) {}

            // return Text('');
          }),
    );
  }
}
