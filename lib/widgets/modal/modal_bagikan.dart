import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/newCalender.dart';
import 'package:budgetin/widgets/reusable/rangeDate.dart';
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
  int _selectedIndex = -1;

  void _handleSelect(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1; // Unselect if already selected
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
                  _selectedIndex == 0,
                  (isSelected) => _handleSelect(0),
                ),
                _box(
                  'assets/images/word.svg',
                  _selectedIndex == 1,
                  (isSelected) => _handleSelect(1),
                ),
                _box(
                  'assets/images/excel.svg',
                  _selectedIndex == 2,
                  (isSelected) => _handleSelect(2),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 6),
              child: const Text(
                "Tanggal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            RangeDate(),
          ],
        )),
        actions: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: Expanded(
                child: TextButton(
                  onPressed: () {
                    // Apply filter logic here
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(BudgetinColors.biru50),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(
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
              ),
            )));
  }

  Widget _box(final String image, bool isSelected, Function(bool) onSelect) {
    return InkWell(
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
              color: isSelected ? Colors.blue : Color(0xFFF2F2F2),
            ),
            // Layer kedua: Icon
            SvgPicture.asset(
              image,
              color:
                  isSelected ? Color(0xFFF2F2F2) : BudgetinColors.hitamPutih50,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _box(final String image,) {
  //   return InkWell(
  //      onTap: () {
  //       setState(() {
  //         _isPressed = !_isPressed;
  //       });
  //     },

  //     child: Center(
  //         child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           width: 55,
  //           height: 55,
  //           color: _isPressed ? Colors.blue : Color(0xFFF2F2F2),
  //         ),
  //         // Layer kedua: Icon
  //         SvgPicture.asset(image, color: _isPressed ? Color(0xFFF2F2F2) : BudgetinColors.hitamPutih50,),
  //       ],
  //     )),
  //   );
  // }
}

Future<void> showModalBagikan(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ShareDialog();
    },
  );
}
