import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/widgets/category/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: SizedBox(
                // height: 300,
                child: CustomPaint(
                  size: const Size(50, 20),
                  painter: SliderPaint(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              // margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Detail Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close_rounded))
                  ],
                ),
              ),
            ),
            Text(transaction.transaction.amount.toString())
          ],
        ),
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
