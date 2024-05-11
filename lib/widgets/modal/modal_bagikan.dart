import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BudgetinModal(
        title: TitleModal(title: 'Bagikan'),
        content: SizedBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 6),
              child: const Text(
                "Opsi",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(
                  'assets/images/pdf.svg',
                ),
                _box(
                  'assets/images/word.svg',
                ),
                _box(
                  'assets/images/excel.svg',
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 6),
              child: const Text(
                "Tanggal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )));
  }

  Widget _box(final String image) {
    return InkWell(
      onTap: (){},
      child: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            color: Color(0xFFF2F2F2),
          ),
          // Layer kedua: Icon
          SvgPicture.asset(image),
        ],
      )),
    );
  }
}

Future<void> showModalBagikan(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ShareDialog();
    },
  );
}
