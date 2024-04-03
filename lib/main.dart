import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppDb? database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MainScreen(),
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'));
  }
}
