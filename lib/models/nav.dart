import 'package:flutter/material.dart';

class Nav {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;

  Nav({required this.page, required this.navKey});
}
