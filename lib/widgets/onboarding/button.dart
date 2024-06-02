import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final bool blok;
  final double? width;
  final void Function() onPressed;
  const ButtonCustom(
      {super.key,
      required this.title,
      required this.blok,
      required this.onPressed,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              blok ? BudgetinColors.biru50 : Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                  color: blok ? Colors.transparent : BudgetinColors.biru50),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: blok ? Colors.white : BudgetinColors.biru50,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
