import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/tracker_service.dart';
import 'package:budgetin/screens/on_boarding.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

AppDb? db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await initializeDb();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

Future<AppDb> initializeDb() async {
  return AppDb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TrackerService tracker = TrackerService();

    return MaterialApp(
        color: BudgetinColors.hitamPutih10,
        home: FutureBuilder(
          future: db!.isSaldoNotCretedYet(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              tracker.track('on-open-app', withDeviceInfo: true);

              return Scaffold(
                appBar: null,
                backgroundColor: BudgetinColors.biru10,
                body: Center(
                  child: Image.asset('assets/images/loading.gif'),
                ),
              );
            } else if (snapshot.hasData) {
              tracker.track('on-load-app', withDeviceInfo: true);

              if (snapshot.data != null &&
                  snapshot.data![0] == false &&
                  snapshot.data![1] == false) {
                return BottomNavbar();
              } else if (snapshot.data![1] == true) {
                return OnBoardingScreen3();
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
