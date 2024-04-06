import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:budgetin/screens/mainscreen.dart';
import 'package:budgetin/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
          animationDuration: Duration(milliseconds: 2000),
          splash: Center(
            child: Image.asset(
              "assets/images/BudgetIn.png",
            ),
          ),
          backgroundColor: biru20,
          splashTransition: SplashTransition.scaleTransition,
          splashIconSize: MediaQuery.of(context).size.width * 2,
          nextScreen: BudgetinHomePage(),
        ),
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'));
  }
}

class BudgetinHomePage extends StatelessWidget {
  const BudgetinHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
