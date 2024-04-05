import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Riwayat{
  String title;
  String tanggal;
  String money;

  Riwayat({required this.title, required this.tanggal,required this.money });
}

var riwayatList =[
  Riwayat(title: "Olahraga", tanggal: "1 Juni 2023", money: "10.000"),
  Riwayat(title: "Makan", tanggal: "1 Juni 2023", money: "20.000"),
  Riwayat(title: "Kuliah", tanggal: "1 Juni 2023", money: "40.000"),
  Riwayat(title: "Makeup", tanggal: "1 Juni 2023", money: "20.000"),
  Riwayat(title: "Makeup", tanggal: "1 Juni 2023", money: "90.000"),
  Riwayat(title: "Belanja", tanggal: "1 Juni 2023", money: "60.000"),
  Riwayat(title: "Elektronik", tanggal: "1 Juni 2023", money: "70.000"),
  Riwayat(title: "Buku", tanggal: "1 Juni 2023", money: "80.000"),
  Riwayat(title: "Belanja", tanggal: "1 Juni 2023", money: "30.000"),
  Riwayat(title: "Baju", tanggal: "1 Juni 2023", money: "20.000")
  ];


  class PlayerSeries {
  final String month;
  final int pengeluaran;
  final charts.Color barColor;
  
  PlayerSeries(
      {required this.month, required this.pengeluaran, required this.barColor});
}

final List<PlayerSeries> data = [
    PlayerSeries(
      month: "Jan",
      pengeluaran: 13,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Feb",
      pengeluaran: 6,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Mar",
      pengeluaran: 15,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Apr",
      pengeluaran: 12,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Mei",
      pengeluaran: 13,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Jun",
      pengeluaran: 5,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Jul",
      pengeluaran: 9,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Aug",
      pengeluaran: 19,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Sep",
      pengeluaran: 8,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Okt",
      pengeluaran: 11,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Nov",
      pengeluaran: 13,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
    PlayerSeries(
      month: "Des",
      pengeluaran: 8,
      barColor: charts.ColorUtil.fromDartColor(Color(0xFFA4CEFF)),
    ),
  ];
