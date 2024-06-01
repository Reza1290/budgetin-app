import 'package:flutter/material.dart';

class TitleModal extends StatelessWidget {
  final String title;
  const TitleModal({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              right: -8,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  weight: 200,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            )
          ],
        ));
  }
}
