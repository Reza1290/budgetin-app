import 'package:flutter/material.dart';

const Color biruPrimary = Color.fromRGBO(29, 119, 255, 1);
const Color biru10 = Color.fromRGBO(235, 243, 255, 1);
const Color merah60 = Color.fromRGBO(215, 42, 42, 1);
const Color merah50 = Color.fromRGBO(249, 61, 61, 1);
const Color merah10 = Color.fromRGBO(255, 236, 236, 1);
const Color hijau80 = Color.fromRGBO(22, 165, 82, 1);
const Color kuning50 = Color.fromRGBO(255, 225, 65, 1);
const Color kuningWarn = Color(0xffFCE467);
const Color hijauWarn = Color(0xff6BEB68);
const Color merahWarn = Color(0xffFC6767);
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

class BudgetinColors {
  // Biru
  static const Map<String, Color> _biru = {
    'biru100': Color(0xFF002255),
    'biru90': Color(0xFF002F77),
    'biru80': Color(0xFF003D99),
    'biru70': Color(0xFF004BBB),
    'biru60': Color(0xFF0C5FDD),
    'biru50': Color(0xFF1D77FF),
    'biru40': Color(0xFF1D77FF),
    'biru30': Color(0xFF83B4FF),
    'biru20': Color(0xFFD4E5FF),
    'biru10': Color(0xFFEBF3FF),
  };

  static Color get biru100 => _biru['biru100']!;
  static Color get biru90 => _biru['biru90']!;
  static Color get biru80 => _biru['biru80']!;
  static Color get biru70 => _biru['biru70']!;
  static Color get biru60 => _biru['biru60']!;
  static Color get biru50 => _biru['biru50']!;
  static Color get biru40 => _biru['biru40']!;
  static Color get biru30 => _biru['biru30']!;
  static Color get biru20 => _biru['biru20']!;
  static Color get biru10 => _biru['biru10']!;

  // Merah
  static const Map<String, Color> _merah = {
    'merah100': Color(0xFF4F0000),
    'merah90': Color(0xFF710505),
    'merah80': Color(0xFF930E0E),
    'merah70': Color(0xFFB51A1A),
    'merah60': Color(0xFFD72A2A),
    'merah50': Color(0xFFF93D3D),
    'merah40': Color(0xFFFF6A6A),
    'merah30': Color(0xFFFF9595),
    'merah20': Color(0xFFFFC0C0),
    'merah10': Color(0xFFFFECEC),
  };

  static Color get merah100 => _merah['merah100']!;
  static Color get merah90 => _merah['merah90']!;
  static Color get merah80 => _merah['merah80']!;
  static Color get merah70 => _merah['merah70']!;
  static Color get merah60 => _merah['merah60']!;
  static Color get merah50 => _merah['merah50']!;
  static Color get merah40 => _merah['merah40']!;
  static Color get merah30 => _merah['merah30']!;
  static Color get merah20 => _merah['merah20']!;
  static Color get merah10 => _merah['merah10']!;

  // Kuning
  static const Map<String, Color> _kuning = {
    'kuning100': Color(0xFF554801),
    'kuning90': Color(0xFF776507),
    'kuning80': Color(0xFF998310),
    'kuning70': Color(0xFFBBA21D),
    'kuning60': Color(0xFFDDC12D),
    'kuning50': Color(0xFFFFE141),
    'kuning40': Color(0xFFFFE86C),
    'kuning30': Color(0xFFFFEE96),
    'kuning20': Color(0xFFFFF5C1),
    'kuning10': Color(0xFFFFFCEC),
  };

  static Color get kuning100 => _kuning['kuning100']!;
  static Color get kuning90 => _kuning['kuning90']!;
  static Color get kuning80 => _kuning['kuning80']!;
  static Color get kuning70 => _kuning['kuning70']!;
  static Color get kuning60 => _kuning['kuning60']!;
  static Color get kuning50 => _kuning['kuning50']!;
  static Color get kuning40 => _kuning['kuning40']!;
  static Color get kuning30 => _kuning['kuning30']!;
  static Color get kuning20 => _kuning['kuning20']!;
  static Color get kuning10 => _kuning['kuning10']!;

  // Hijau
  static const Map<String, Color> _hijau = {
    'hijau100': Color(0xFF016129),
    'hijau90': Color(0xFF09833D),
    'hijau80': Color(0xFF16A552),
    'hijau70': Color(0xFF26C76A),
    'hijau60': Color(0xFF3BE984),
    'hijau50': Color(0xFF50FF9A),
    'hijau40': Color(0xFF77FFB0),
    'hijau30': Color(0xFF9EFFC7),
    'hijau20': Color(0xFFC6FFDE),
    'hijau10': Color(0xFFEDFFF5),
  };

  static Color get hijau100 => _hijau['hijau100']!;
  static Color get hijau90 => _hijau['hijau90']!;
  static Color get hijau80 => _hijau['hijau80']!;
  static Color get hijau70 => _hijau['hijau70']!;
  static Color get hijau60 => _hijau['hijau60']!;
  static Color get hijau50 => _hijau['hijau50']!;
  static Color get hijau40 => _hijau['hijau40']!;
  static Color get hijau30 => _hijau['hijau30']!;
  static Color get hijau20 => _hijau['hijau20']!;
  static Color get hijau10 => _hijau['hijau10']!;

  // Hitam dan Putih
  static const Map<String, Color> _hitamPutih = {
    'hitamPutih100': Color(0xFF3D3D3D),
    'hitamPutih90': Color(0xFF525252),
    'hitamPutih80': Color(0xFF666666),
    'hitamPutih70': Color(0xFF7A7A7A),
    'hitamPutih60': Color(0xFF8F8F8F),
    'hitamPutih50': Color(0xFFA3A3A3),
    'hitamPutih40': Color(0xFFD1D1D1),
    'hitamPutih30': Color(0xFFF2F2F2),
    'hitamPutih20': Colors.white,
    'hitamPutih10': Color(0xFFFFFFFF),
  };

  static Color get hitamPutih100 => _hitamPutih['hitamPutih100']!;
  static Color get hitamPutih90 => _hitamPutih['hitamPutih90']!;
  static Color get hitamPutih80 => _hitamPutih['hitamPutih80']!;
  static Color get hitamPutih70 => _hitamPutih['hitamPutih70']!;
  static Color get hitamPutih60 => _hitamPutih['hitamPutih60']!;
  static Color get hitamPutih50 => _hitamPutih['hitamPutih50']!;
  static Color get hitamPutih40 => _hitamPutih['hitamPutih40']!;
  static Color get hitamPutih30 => _hitamPutih['hitamPutih30']!;
  static Color get hitamPutih20 => _hitamPutih['hitamPutih20']!;
  static Color get hitamPutih10 => _hitamPutih['hitamPutih10']!;
}

