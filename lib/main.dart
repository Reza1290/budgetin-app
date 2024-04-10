import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppDb? db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await initializeDb();
  runApp(MyApp());
}

Future<AppDb> initializeDb() async {
  // Initialize your database here, e.g., connecting to it
  return AppDb();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BottomNavbar(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ));
  }
}
