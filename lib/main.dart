import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/mainscreen.dart';
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

        home: BudgetinHomePage(),
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
