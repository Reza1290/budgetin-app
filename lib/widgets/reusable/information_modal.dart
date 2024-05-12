import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      padding: EdgeInsets.all(24),
      title: Text(""),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              content,
              // width: 173.0,
              // height: 159.0,
            ),
            // Image.asset(
            //   content,
            //   // width: 173.0,
            //   // height: 159.0,
            // ),
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
                        color: Color(0xFFF2F2F2),
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
                SizedBox(
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
                      child: Center(
                        child: const Text(
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

Future<void> showModalInformation(
  BuildContext context,
  String content,
  String message,
  bool isFailed, {
  Function? onPressed, // Tambahkan tanda tanya (?) untuk parameter opsional
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if (isFailed)
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      return PopScope(
        canPop: false,
        child: InformationModal(
          message: message,
          isFailed: isFailed,
          content: content,
          onPressed: onPressed,
        ),
      );
    },
  );
}
