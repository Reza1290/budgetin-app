import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: 6), upperBound: 100.0);
    // _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.forward();

    // _animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse(from: 2.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BudgetinColors.biru10,
      body: Center(
        child: Text(
          '${_controller.value.toInt()}',
        ),
      ),
    );
  }
}
