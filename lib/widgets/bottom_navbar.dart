import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          RiwayatTransaksiPage(),
          Text('Secret'),
          Text('none'),
          Text('none')
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
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
          onPressed: () {},
          child: const Icon(
            Icons.add,
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
            height: size.width * .155,
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
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
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

  Future pageLayout() {
    return Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  List<String> menu = ["Beranda", "Transaksi", "", "Statistik", "Pengaturan"];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.receipt_rounded,
    Icons.document_scanner,
    Icons.assessment_rounded,
    Icons.settings_rounded,
  ];
}
