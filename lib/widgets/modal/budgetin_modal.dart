import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';

class BudgetinModal extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Widget? actions;
  final EdgeInsets? padding;
  const BudgetinModal(
      {super.key,
      required this.title,
      required this.content,
      this.actions,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: EdgeInsets.only(left: 32, right: 32),
      backgroundColor: BudgetinColors.hitamPutih10,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title,
              content,
              actions ?? SizedBox()
            ], // You can add more children here
          ),
        ),
      ),
    );
  }
}
