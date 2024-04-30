import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/on_boarding.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

AppDb? db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await initializeDb();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      
        home: OnBoardingScreen1(),
        // BottomNavbar(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ));
  }
}
