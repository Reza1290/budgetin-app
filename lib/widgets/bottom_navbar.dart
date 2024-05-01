import 'package:budgetin/screens/category_screen.dart';
import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/screens/statistic_screen.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/main/select_category_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    super.key,
    this.initIndex,
  });
  final int? initIndex;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with SingleTickerProviderStateMixin {
  var currentIndex = 0;
  static List<Widget> page = <Widget>[
    HomePage(
      changeTab: () {},
    ),
    RiwayatTransaksiPage(),
    // Center(child: Image.asset('assets/images/loading.gif')),
    Container(),
    // FaqPage(),
    CategoryScreen(),
    StatisticScreen(),
  ];

  // static const List<Widget> nav = <Widget>[
  //   Tab(),
  // ];
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initIndex ?? currentIndex;
    _tabController = TabController(
        vsync: this, length: page.length, initialIndex: currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          HomePage(
            changeTab: () => setState(
              () {
                _tabController.animateTo(3);
                currentIndex = 3;
              },
            ),
          ),
          RiwayatTransaksiPage(),
          // Center(child: Image.asset('assets/images/loading.gif')),
          Container(),
          // FaqPage(),
          CategoryScreen(),
          StatisticScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: BudgetinColors.biru50,
          elevation: 0.0,
          disabledElevation: 0,
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SelectCategoryPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeIn;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ));
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
            weight: 10,
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 28,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 100,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              height: 74,
              width: 74,
            ),
          ),
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
              tabAlignment: TabAlignment.fill,
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              onTap: (index) {
                setState(
                  () {
                    currentIndex = index != 2 ? index : currentIndex;
                  },
                );
              },
              indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
              tabs: page.map((Widget test) {
                final List list = Set.from(page).toList();
                final int index = list.indexOf(test);
                return index != 2
                    ? InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              margin: EdgeInsets.only(
                                bottom: index == currentIndex
                                    ? 0
                                    : size.width * .029,
                                right: size.width * .0422,
                                left: size.width * .0422,
                              ),
                              width: size.width * .128,
                              height:
                                  index == currentIndex ? size.width * .014 : 0,
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10),
                                ),
                              ),
                            ),
                            Icon(
                              listOfIcons[index],
                              size: 28,
                              color: index == currentIndex
                                  ? Colors.blueAccent
                                  : Colors.black38,
                            ),
                            Text(
                              menu[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: index == currentIndex
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                            ),
                            // SizedBox(height: size.width * .03),
                          ],
                        ))
                    : Container(
                        width: size.width * .128,
                        height: index == currentIndex ? size.width * .014 : 0,
                      );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 28,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              height: 74,
              width: 74,
            ),
          ),
        ],
      ),
    );
  }

  List<String> menu = ["Beranda", "Transaksi", "", "Kategori", "Statistik"];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.receipt_rounded,
    Icons.document_scanner,
    Icons.category_rounded,
    Icons.assessment_rounded,
  ];
}
