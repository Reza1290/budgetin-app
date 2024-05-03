import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BudgetinSheet extends StatelessWidget {
  BudgetinSheet({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      reverse: true,
      child: Padding(
          padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: body),
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
    paint.color = BudgetinColors.hitamPutih50;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(60, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
