import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budgetin/widgets/calendar.dart';
import 'package:intl/intl.dart';

class AddTransaksi extends StatefulWidget {
  final int categoryId;
  const AddTransaksi({super.key, required this.categoryId});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String? nama;
  String? nominal;
  String? deskripsi;
  bool isFormSubmitted = false;

  DateTime now = DateTime.now();

  Future insert(String name, String description, int amount, DateTime date,
      int categoryId) async {
    final row = await db!.into(db!.transactions).insertReturning(
        TransactionsCompanion.insert(
            name: name,
            description: description,
            category_id: categoryId,
            amount: amount,
            transaction_date: date));
  }

  TextEditingController nameTransaksiController = TextEditingController();
  // TextEditingController amountTransaksiController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  TextEditingController deskripsiTransaksiController = TextEditingController();
  TextEditingController dateTransaksiController = TextEditingController();

  late final FocusNode _nameFocusNode;
  late final FocusNode _moneyFocusNode;
  late final FocusNode _descFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameFocusNode = FocusNode();
    _moneyFocusNode = FocusNode();
    _descFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameFocusNode.dispose();
    _descFocusNode.dispose();
    _moneyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6.0),
                  InputText(
                    controller: nameTransaksiController,
                    hintText: "Nama Transaksi",
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    "Nominal",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6.0),
                  InputMoney(
                    // formKey: _formKey,
                    controller: _moneyController,
                    fontSize: 12,
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6.0),
                  InputText(
                    controller: deskripsiTransaksiController,
                    hintText: 'Deskripsi Transaksi ',
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    "Tanggal",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6.0),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? pickedDate =
                          await selectDate(context, selectedDate);
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          suffixIcon: const Icon(Icons.calendar_month),
                          hintText:
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          insert(
                              nameTransaksiController.text,
                              deskripsiTransaksiController.text,
                              int.parse(
                                  _moneyController.text.replaceAll('.', '')),
                              selectedDate,
                              widget.categoryId);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavbar(initIndex: 1),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (isFormSubmitted &&
                      (nama == null ||
                          nama!.isEmpty ||
                          nominal == null ||
                          nominal!.isEmpty ||
                          deskripsi == null ||
                          deskripsi!.isEmpty)) ...[
                    const SizedBox(height: 5.0),
                    const AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: 1,
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form submitted successfully')),
    );
  }
}
