import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showSheetCreateCategory(BuildContext context) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    backgroundColor: BudgetinColors.hitamPutih10,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (context) {
      return BudgetinSheet();
    },
  );
}
