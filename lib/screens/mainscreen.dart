import 'package:budgetin/models/nav.dart';
import 'package:budgetin/screens/add_transaksi.dart';
import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final historyNavKey = GlobalKey<NavigatorState>();
  final reportNavKey = GlobalKey<NavigatorState>();
  final faqNavKey = GlobalKey<NavigatorState>();

  int selectedTab = 0;

  List<Nav> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      Nav(page: const HomePage(), navKey: homeNavKey),
      Nav(page: const RiwayatTransaksiPage(), navKey: historyNavKey),
      Nav(page: const TabPage(tab: 3), navKey: reportNavKey),
      Nav(page: const TabPage(tab: 4), navKey: faqNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map(
                (e) => Navigator(
                  key: e.navKey,
                  onGenerateInitialRoutes: (navigator, initialRoue) {
                    return [
                      MaterialPageRoute(
                        builder: (context) => e.page,
                      )
                    ];
                  },
                ),
              )
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, -4),
                )
              ]),
          margin: const EdgeInsets.only(top: 10),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  ),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2 * 3,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              // height: 300,
                              child: CustomPaint(
                                size: const Size(90, 20),
                                painter: SliderPaint(),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Pilih Kategori',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 10),
                              // height: double.infinity,
                              // height: MediaQuery.of(context).size.height / 2.32,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddTransaksi())),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 44,
                                              height: 44,
                                              padding: EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.blue.shade200,
                                              ),
                                              child: Image.asset(
                                                'assets/icons/lainnya.png',
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 12.0),
                                              child: Text(
                                                "Makanan",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )),
                  );
                },
              );
            },
            elevation: 0,
            backgroundColor: const Color.fromRGBO(29, 119, 255, 1),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 6,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: NavBarBottom(
            pageIndex: selectedTab,
            onTap: (index) {
              if (index == selectedTab) {
                items[index]
                    .navKey
                    .currentState
                    ?.popUntil((route) => route.isFirst);
              } else {
                setState(() {
                  selectedTab = index;
                });
              }
            }),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Kosong:D'));
  }
}

class SliderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.black12;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(90, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
