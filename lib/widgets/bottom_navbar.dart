import 'package:budgetin/screens/faq_page.dart';
import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/them.dart';
import 'package:budgetin/widgets/main/select_category_dialog.dart';
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
  static const List<Widget> page = <Widget>[
    HomePage(),
    RiwayatTransaksiPage(),
    Center(child: Text('Secret')),
    Text('none'),
    FaqPage(),
  ];

  // static const List<Widget> nav = <Widget>[
  //   Tab(),
  // ];
  var currentIndex = 0;
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
          children: page.map((Widget page) {
            return page;
          }).toList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: PrimaryColor.shade500,
          elevation: 0.0,
          disabledElevation: 0,
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SelectCategoryDialog(),
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

  List<String> menu = ["Beranda", "Transaksi", "", "Statistik", "FAQ"];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.receipt_rounded,
    Icons.document_scanner,
    Icons.assessment_rounded,
    Icons.live_help_rounded,
  ];
}

/*

child: Center(
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => index != 2
                    ? InkWell(
                        onTap: () {
                          setState(
                            () {
                              currentIndex = index != 2 ? index : currentIndex;
                            },
                          );
                          _pageController.animateToPage(index,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                          // _pageController.jumpToPage(index);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
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
                              decoration: BoxDecoration(
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
                            Text(menu[index]),
                            // SizedBox(height: size.width * .03),
                          ],
                        ))
                    : Container(
                        width: size.width * .128,
                        height: index == currentIndex ? size.width * .014 : 0,
                      ),
              ),
            ),
*/
