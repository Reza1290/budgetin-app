import 'package:budgetin/screens/mainscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgetin',
      // Set Raleway as the default app font.
      theme: ThemeData(fontFamily: 'Nunito'),
      home: const BudgetinHomePage(),
    );
  }
}

class BudgetinHomePage extends StatelessWidget {
  const BudgetinHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
