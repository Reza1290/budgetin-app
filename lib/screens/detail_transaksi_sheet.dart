import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/providers/date_formatter.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';

void showDetailTransaksiSheet(
    BuildContext context, TransactionWithCategory transaksi) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(12),
        topStart: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return _DetailTransaksiSheetContent(
          transaksi); // Return the content widget
    },
  );
}

class _DetailTransaksiSheetContent extends StatelessWidget {
  final TransactionWithCategory transaction;

  const _DetailTransaksiSheetContent(this.transaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4 * 3,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: SizedBox(
                  // height: 300,
                  child: CustomPaint(
                    size: const Size(50, 20),
                    painter: SliderPaint(),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Detail Transaksi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Color(0xFFD4E5FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                Text(
                                  TextCurrencyFormat.format(transaction
                                      .transaction.amount
                                      .toString()),
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(" / " +
                                    TextCurrencyFormat.format(
                                        transaction.category.total.toString()))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nama Transaksi ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                transaction.transaction.name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            color: const Color(0xFFD1D1D1),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Kategori ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                transaction.category.name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            color: const Color(0xFFD1D1D1),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tanggal ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                HumanReadableDateFormatter.formatToDate(
                                    transaction.transaction.transaction_date),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // berikan garis bawah abu2
                          Container(
                            height: 1,
                            color: const Color(0xFFD1D1D1),
                          ),
                          const SizedBox(height: 15),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Deskripsi",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ReadMoreText(
                              transaction.transaction.description == ''
                                  ? 'Deskripsi Tidak ada.'
                                  : transaction.transaction.description,
                              trimMode: TrimMode.Line,
                              trimLines: 2,
                              colorClickableText: Color(0xFF83B4FF),
                              trimCollapsedText: 'Selengkapnya',
                              trimExpandedText: ' Sembunyikan',
                              moreStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF83B4FF)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class SliderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.black12;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(50, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
