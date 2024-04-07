import 'package:budgetin/models/database.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/success_category_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetin/widgets/modal_icon_kategori.dart';
import 'package:drift/drift.dart' as drift;

Future<void> showModalTambahKategori(BuildContext context, AppDb _db) {
  bool _isButtonEnabled = false;
  String _iconKategori = '';
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              // height: double.infinity, // make this dynamic
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
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

                                final result =
                                    await showModalIconKategori(context);

                                setState(() {
                                  _iconKategori =
                                      result ?? "assets/icons/lainnya.png";
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
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
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
                            InputText(
                              controller: _nameController,
                              hintText: "Nama Kategori",
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Alokasi Dana',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(height: 6.0),
                            InputMoney(
                              controller: _moneyController,
                              fontSize: 12,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled
                                ? () {
                                    if (formKey.currentState!.validate()) {
                                      final entry = CategoriesCompanion(
                                        icon: drift.Value(_iconKategori),
                                        name: drift.Value(_nameController.text),
                                        total: drift.Value(int.parse(
                                            _moneyController.text
                                                .replaceAll('.', ''))),
                                      );

                                      _db.insertCategory(entry).then((value) {
                                        Navigator.of(context).pop();
                                        showSuccessCategoryAlert(context,
                                            'Kategori berhasil disimpan!');
                                      });
                                    }
                                  }
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                _isButtonEnabled ? Colors.blue : Colors.grey,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
