import 'package:flutter/material.dart';

class SelectCategoryDialog extends StatefulWidget {
  const SelectCategoryDialog({super.key});

  @override
  State<SelectCategoryDialog> createState() => _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetAnimationCurve: Easing.linear,
      child: Container(
        child: Text('HelloGUYS'),
      ),
    );
  }
}
