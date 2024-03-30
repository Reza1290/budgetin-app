import 'package:flutter/material.dart';
import 'package:budgetin/widgets/modal_icon_kategori.dart';

Future<void> showModalTambahKategori(BuildContext context) {
  bool _isButtonEnabled = false;
  String _iconKategori = '';

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Center(
                    child: Text(
                      'Tambah Kategori',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        weight: 100,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      // kosongkan icon kategori sebelumnya
                      setState(() {
                        _isButtonEnabled = false;
                      });

                      final result = await showModalIconKategori(context);

                      // Update status tombol berdasarkan icon yang dipilih
                      setState(() {
                        _iconKategori = result ?? "assets/icons/lainnya.png";
                        _isButtonEnabled = true;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(201, 218, 255, 1),
                      ),
                      child: Center(
                        child: _iconKategori.isNotEmpty
                            ? Image.asset(_iconKategori)
                            : const Icon(
                                Icons.add_rounded,
                                color: Color.fromARGB(255, 114, 114, 114),
                                size: 45,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Icon Kategori',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Nama Kategori',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6.0),
                  TextField(
                    onChanged: (value) {
                      // Update status tombol berdasarkan isi TextField
                      setState(() {
                        _isButtonEnabled = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      hintText: 'Nama Kategori',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Alokasi Dana',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 6.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      prefix: Text('Rp '),
                      prefixStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? () {} : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isButtonEnabled ? Colors.blue : Colors.grey,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          );
        },
      );
    },
  );
}
