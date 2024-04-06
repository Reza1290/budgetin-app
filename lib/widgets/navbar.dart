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
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: 60,
            color: Colors.blueAccent,
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
      child: Icon(icon, color: selected ? Colors.white : Colors.blue.shade200),
    ));
  }
}
