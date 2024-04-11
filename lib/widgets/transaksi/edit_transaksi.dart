import 'package:budgetin/main.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/widgets/calendar.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:flutter/material.dart';

class EditTransaksi extends StatefulWidget {
  final TransactionWithCategory transaction;
  const EditTransaksi({super.key, required this.transaction});

  @override
  State<EditTransaksi> createState() => _EditTransaksiState();
}

class _EditTransaksiState extends State<EditTransaksi>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController _controller;
  DateTime selectedDate = DateTime.now();

  bool isFormSubmitted = false;

  DateTime now = DateTime.now();

  TextEditingController nameTransaksiController = TextEditingController();
  // TextEditingController amountTransaksiController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  TextEditingController deskripsiTransaksiController = TextEditingController();
  TextEditingController dateTransaksiController = TextEditingController();
  late int temp;
  late final FocusNode _nameFocusNode;
  late final FocusNode _moneyFocusNode;
  late final FocusNode _descFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    temp = widget.transaction.transaction.amount;
    nameTransaksiController.text = widget.transaction.transaction.name;
    _moneyController.text = widget.transaction.transaction.amount.toString();
    deskripsiTransaksiController.text =
        widget.transaction.transaction.description;
    selectedDate = widget.transaction.transaction.transaction_date;
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
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Transaksi',
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int curr = await db!.sumExpenseCategory(
                              widget.transaction.category.id);
                          if (int.parse(_moneyController.text
                                      .replaceAll('.', '')) +
                                  curr -
                                  temp <
                              widget.transaction.category.total) {
                            db!.updateTransactionRepo(
                                widget.transaction.transaction.id,
                                nameTransaksiController.text,
                                int.parse(
                                    _moneyController.text.replaceAll('.', '')),
                                widget.transaction.transaction.category_id,
                                deskripsiTransaksiController.text,
                                selectedDate);
                            _simpanTransaksi(context);
                          } else {
                            showFailedAlert(
                                context, "Nominal Diambang Batas Maksimal");
                          }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _simpanTransaksi(BuildContext context) {
  Navigator.pop(context);
  showSuccessAlert(context, "Transaksi Berhasil Diubah!");
}
