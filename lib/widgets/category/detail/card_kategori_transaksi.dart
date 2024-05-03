import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardKategoriTransaksi extends StatefulWidget {
  const CardKategoriTransaksi(
      {super.key, required this.data, required this.total});
  final Category data;
  final int total;

  @override
  State<CardKategoriTransaksi> createState() => _CardKategoriTransaksiState();
}

class _CardKategoriTransaksiState extends State<CardKategoriTransaksi> {
  late bool isMore;
  late Widget svg;
  void initState() {
    // TODO: implement initState
    super.initState();
    svg = SvgPicture.asset(
      widget.data.icon == '' ? 'assets/icons/Lainnya.svg' : widget.data.icon,
      width: 55.0,
      height: 53.0,
    );
    isMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 342.0,
          height: isMore ? null : 167.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 17.0,
              ),
              Container(
                width: 100.0,
                height: 98.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF2F2F2),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22.0, 22.0, 24.0, 24.0),
                  child: svg,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        widget.data.name,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: isMore
                                ? TextOverflow.clip
                                : TextOverflow.ellipsis),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isMore = !isMore;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
