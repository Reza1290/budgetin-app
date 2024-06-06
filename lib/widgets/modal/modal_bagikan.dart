import 'dart:ui';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/utilities/export_excel.dart';
import 'package:budgetin/utilities/export_pdf.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/new_calender.dart';
import 'package:budgetin/widgets/reusable/range_date.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ShareDialog extends StatefulWidget {
  const ShareDialog({super.key});

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  // late DateTime _selectedDate = DateTime.now();
  // late DateTime _selectedDate2 = DateTime.now();
  // bool _isPressed = false;
  List<DateTime> selectedTanggal = [DateTime.now(), DateTime.now()];
  int _selectedIndex = 0;

  void _handleSelect(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = 0; // Unselect if already selected
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BudgetinModal(
        title: const TitleModal(title: 'Bagikan'),
        content: SizedBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 6),
              child: Text(
                "Opsi",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(
                  'assets/images/pdf.svg',
                  _selectedIndex == 0,
                  (isSelected) => _handleSelect(0),
                ),
                // _box(
                //   'assets/images/word.svg',
                //   _selectedIndex == 1,
                //   (isSelected) => _handleSelect(0),
                // ),
                // _box(
                //   'assets/images/excel.svg',
                //   _selectedIndex == 2,
                //   (isSelected) => _handleSelect(2),
                // ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 6),
              child: Text(
                "Tanggal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            RangeDate(
              setTanggal: (tanggal) {
                selectedTanggal = tanggal;
              },
            ),
          ],
        )),
        actions: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  PdfService pdf = PdfService();
                  // ExcelService excel = ExcelService();
                  List<TransactionWithCategory> ts = await db!
                      .getTransactionInRange(
                          selectedTanggal[0], selectedTanggal[1]);

                  DateTime adjustedStart = DateTime(
                      selectedTanggal[0].year,
                      selectedTanggal[0].month,
                      selectedTanggal[0].day,
                      0,
                      0,
                      0);

                  DateTime adjustedEnd = DateTime(
                      selectedTanggal[1].year,
                      selectedTanggal[1].month,
                      selectedTanggal[1].day,
                      23,
                      59,
                      59);
                  if (_selectedIndex == 0) {
                    final bytes = await pdf.generatePdf(ts);
                    pdf.savedPdfFile(
                        'BudgetIn  $adjustedStart - $adjustedEnd Laporan.pdf',
                        bytes);
                  } else if (_selectedIndex == 1) {
                    // final bytes = await pdf.generatePdf(ts);
                    // pdf.savedPdfFile(
                    //     'BudgetIn  $adjustedStart - $adjustedEnd Laporan.docx',
                    //     bytes);
                  } else if (_selectedIndex == 2) {
                    // final bytes = await excel.generateExcel(ts);
                    // excel.savedExcelFile(
                    //     'BudgetIn  $adjustedStart - $adjustedEnd Laporan.xlsx',
                    //     bytes);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(BudgetinColors.biru50),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(
                        2), // Atur padding di sini sesuai kebutuhan Anda
                  ),
                ),
                child: Text(
                  'Unduh',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: BudgetinColors.hitamPutih10,
                  ),
                ),
              ),
            )));
  }

  Widget _box(final String image, bool isSelected, Function(bool) onSelect) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onSelect(!isSelected);
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.86),
                color: isSelected ? BudgetinColors.biru50 : const Color(0xFFF2F2F2),
              ),
            ),
            // Layer kedua: Icon
            SvgPicture.asset(
              image,
              // ignore: deprecated_member_use
              color:
                  isSelected ? const Color(0xFFF2F2F2) : BudgetinColors.hitamPutih50,
            ),
          ],
        ),
      ),
    );
  }
}

Future<Object?> showModalBagikan(BuildContext context) async {
  return Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: const ShareDialog(),
              ),
            ),
          ],
        ),
      );
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    },
  ));
}
