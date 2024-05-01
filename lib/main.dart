import 'package:budgetin/models/database.dart';
import 'package:budgetin/screens/on_boarding.dart';
import 'package:budgetin/utilities/them.dart';
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
  return AppDb();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
          future: db!.isSaldoNotCretedYet(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: null,
                backgroundColor: BudgetinColors.biru10,
                body: Center(
                  child: Image.asset('assets/images/loading.gif'),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data == false) {
                // print(snapshot.data);
                return BottomNavbar();
              }
            }
            return OnBoardingScreen1();
          },
        ),
        // BottomNavbar(),
        theme: ThemeData(
          // primarySwatch: Budgetin,
          fontFamily: 'Nunito',
        ));
  }
}
