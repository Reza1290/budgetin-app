import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BudgetinSheet extends StatelessWidget {
  BudgetinSheet({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alokasiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: CustomPaint(
                  size: const Size(60, 20),
                  painter: SliderPaint(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Text(
                'Tambah Kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: BudgetinColors.biru10,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Pilih Ikon',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Nama Kategori',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BudgetinColors.hitamPutih100),
                    ),
                  ),
                  InputText(
                    controller: _nameController,
                    hintText: 'Masukkan Nama Kategori',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      'Nama Kategori',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BudgetinColors.hitamPutih100),
                    ),
                  ),
                  InputMoney(
                    fontSize: 13,
                    controller: _alokasiController,
                    // hintText: 'Masukkan Nama Kategori',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: BudgetinColors.hitamPutih30,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: BudgetinColors.hitamPutih50),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
