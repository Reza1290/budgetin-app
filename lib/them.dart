import 'package:flutter/material.dart';

const Color biruPrimary = Color.fromRGBO(29, 119, 255, 1);
const Color biru10 = Color.fromRGBO(235, 243, 255, 1);
const Color merah60 = Color.fromRGBO(215, 42, 42, 1);
const Color merah50 = Color.fromRGBO(249, 61, 61, 1);
const Color merah10 = Color.fromRGBO(255, 236, 236, 1);
const Color hijau80 = Color.fromRGBO(22, 165, 82, 1);
const Color kuning50 = Color.fromRGBO(255, 225, 65, 1);
const Color kuningWarn = Color(0xffF5EA85);
const Color hijauWarn = Color(0xff8AD1A8);
const Color merahWarn = Color(0xffF7B5B5);
const Color hijau10 = Color.fromRGBO(237, 255, 245, 1);
const Color hitamPrimary = Color.fromRGBO(61, 61, 61, 1);
const Color putih30 = Color.fromRGBO(242, 242, 242, 1);
const Color putih40 = Color.fromRGBO(209, 209, 209, 1);
const Color hitam80 = Color.fromRGBO(102, 102, 102, 1);
const Color hitam50 = Color.fromRGBO(163, 163, 163, 1);
const Color hitam100 = Color(0xff3d3d3d);

class PrimaryColor {
  static const Map<String, Color> _colors = {
    'shade100': Color(0xFFEBF3FF),
    'shade200': Color(0xFFD4E5FF),
    'shade300': Color(0xFF83B4FF),
    'shade400': Color(0xFF1D77FF),
    'shade500': Color(0xFF1D77FF),
    'shade600': Color(0xFF0C5FDD),
    'shade700': Color(0xFF004BBB),
    'shade800': Color(0xFF003D99),
    'shade900': Color(0xFF002F77),
    'shade1000': Color(0xFF002255),
  };

  static Color get shade100 => _colors['shade100']!;
  static Color get shade200 => _colors['shade200']!;
  static Color get shade300 => _colors['shade300']!;
  static Color get shade400 => _colors['shade400']!;
  static Color get shade500 => _colors['shade500']!;
  static Color get shade600 => _colors['shade600']!;
  static Color get shade700 => _colors['shade700']!;
  static Color get shade800 => _colors['shade800']!;
  static Color get shade900 => _colors['shade900']!;
  static Color get shade1000 => _colors['shade1000']!;
}
