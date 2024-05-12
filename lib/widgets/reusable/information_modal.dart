
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
                Container(
                  width: MediaQuery.of(context).size.width/3.2,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: Color(0xFFA3A3A3),
                      ),
                    ),
                  ),
                ),
              
                Container(
                  width: MediaQuery.of(context).size.width/3.2,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xFF1D77FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: onPressed as void Function()? ?? () {},
                    child: const Text(
                      'Ya',
                      style: TextStyle(color: Colors.white),
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
    builder: (BuildContext context) {
      return InformationModal(
        message: message,
        isFailed: isFailed,
        content: content,
        onPressed: onPressed,
      );
    },
  );
}
