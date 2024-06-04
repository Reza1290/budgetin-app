import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';

class InformationModal extends StatelessWidget {
  final String content;
  final String message;
  final bool isFailed;
  final Function? onPressed;

  const InformationModal({
    super.key,
    required this.message,
    required this.isFailed,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BudgetinModal(
      padding: const EdgeInsets.all(24),
      title: const Text(""),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              content,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      actions: isFailed
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Batal',
                            style: TextStyle(
                                color: BudgetinColors.hitamPutih50,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onPressed as void Function()? ?? () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3.2,
                      height: 45,
                      decoration: BoxDecoration(
                        color: BudgetinColors.merah50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Ya',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<Object?> showModalInformation(
  BuildContext context,
  String content,
  String message,
  bool isFailed, {
  Function? onPressed,
}) async {
  return Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      if (isFailed) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.of(context).pop();
        });
      }
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
                child: InformationModal(
                  message: message,
                  isFailed: isFailed,
                  content: content,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    },
  ));
}
