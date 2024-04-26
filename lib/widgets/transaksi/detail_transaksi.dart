import 'package:flutter/material.dart';

class DetailTransaksi extends StatelessWidget {
  const DetailTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _modal(context),
          child: const Text('Detail Transaksi'),
        ),
      ),
    );
  }

  Future<void> _modal(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 325,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Detail Transaksi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(201, 218, 255, 1),
                        ),
                        child: Center(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/food_13636639.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: const Text(
                          'Makanan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText('Nama'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Nasi Goreng'),
                    SizedBox(height: 10.0),
                    _buildTitleText('Nominal'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Rp 20.000'),
                    SizedBox(height: 10.0),
                    _buildTitleText('Deskripsi'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('Beli nasi goreng di gebang'),
                    SizedBox(height: 10.0),
                    _buildTitleText('Tanggal'),
                    SizedBox(height: 6.0),
                    _buildTextFormField('12 Maret 2024'),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  Widget _buildTitleText(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextFormField(String content, {double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          child: TextFormField(
            readOnly: true,
            initialValue: content,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
        ),
      ],
    );
  }
}
