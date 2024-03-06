import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;
  const MyWidget({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
