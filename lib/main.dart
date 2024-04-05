import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// AppDb database = AppDb();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
