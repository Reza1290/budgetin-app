import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/screens/on_boarding.dart';
import 'package:budgetin/utilities/export_pdf.dart';
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

Stream<List<TransactionWithCategory>> getAllTransactions() {
  return db!.getAllTransactionWithCategory(); 
}

Future<AppDb> initializeDb() async {
  return AppDb();
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: BudgetinColors.hitamPutih10,
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
          bottomSheetTheme:
              const BottomSheetThemeData(surfaceTintColor: Colors.white),
          dialogBackgroundColor: Colors.white,

          // primarySwatch: Budgetin,
          fontFamily: 'Nunito',
        ));
  }
}
}