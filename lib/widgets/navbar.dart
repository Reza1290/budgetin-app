import 'dart:io';

import 'package:flutter/material.dart';

class NavBarBottom extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;
  const NavBarBottom({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Platform.isAndroid ? 16 : 0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          // spreadRadius: 5,
          blurRadius: 2,
          offset: const Offset(0, -2),
        )
      ]),
      child: BottomAppBar(
        elevation: 0,
        child: ClipRRect(
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                navItem(
                  Icons.home_rounded,
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                navItem(
                  Icons.receipt_rounded,
                  pageIndex == 1,
                  onTap: () => onTap(1),
                ),
                const SizedBox(
                  width: 60,
                ),
                navItem(
                  Icons.bar_chart_rounded,
                  pageIndex == 2,
                  onTap: () => onTap(2),
                ),
                navItem(
                  Icons.live_help_rounded,
                  pageIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Icon(icon,
          color: selected
              ? const Color.fromRGBO(29, 119, 255, 100)
              : const Color.fromRGBO(204, 204, 204, 100)),
    ));
  }
}
