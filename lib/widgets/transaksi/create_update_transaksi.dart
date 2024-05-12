import 'package:budgetin/controller/transaction_controller.dart';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:budgetin/screens/homepage.dart';
import 'package:budgetin/screens/riwayat_transaksi_page.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/failed_alert.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/reusable/budget_status_card.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:budgetin/widgets/succes_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budgetin/widgets/reusable/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CreateUpdateTransaksiPage extends StatefulWidget {
  final int categoryId;
  final bool? isEditPage;
  final TransactionWithCategory? dataTransaction;
  const CreateUpdateTransaksiPage(
      {super.key,
      required this.categoryId,
      this.isEditPage = false,
      this.dataTransaction});

  @override
  State<CreateUpdateTransaksiPage> createState() =>
      _CreateUpdateTransaksiPageState();
}

class _CreateUpdateTransaksiPageState extends State<CreateUpdateTransaksiPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String? nama;
  String? nominal;
  String? deskripsi;
  bool isFormSubmitted = false;
  late int sisa = 0;
  int temp = 0;

  DateTime now = DateTime.now();

  TextEditingController nameTransaksiController = TextEditingController();
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
    if (widget.isEditPage!) {
      temp = widget.dataTransaction!.transaction.amount;
      nameTransaksiController.text = widget.dataTransaction!.transaction.name;
      _moneyController.text =
          widget.dataTransaction!.transaction.amount.toString();
      deskripsiTransaksiController.text =
          widget.dataTransaction!.transaction.description;
      selectedDate = widget.dataTransaction!.transaction.transaction_date;
    }
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
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
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
                  BudgetStatusCard(
                    categoryId: widget.categoryId,
                    isEditPage: widget.isEditPage!,
                    temp: temp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: const Text(
                            "Tanggal",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate =
                                await selectDate(context, selectedDate);
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: const Text(
                            "Nama",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InputText(
                          controller: nameTransaksiController,
                          hintText: "Nama Transaksi",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: const Text(
                            "Nominal",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InputMoney(
                          // formKey: _formKey,
                          controller: _moneyController,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: const Text(
                            "Deskripsi",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InputText(
                          controller: deskripsiTransaksiController,
                          hintText: 'Deskripsi Transaksi ',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: TextButton(
                      onPressed: () async {
                        bool res = false;
                        if (_formKey.currentState!.validate()) {
                          if (widget.isEditPage!) {
                            res = await TransactionController.update(
                              temp,
                              nameTransaksiController.text,
                              deskripsiTransaksiController.text,
                              int.parse(
                                  _moneyController.text.replaceAll('.', '')),
                              selectedDate,
                              widget.dataTransaction!.transaction.id,
                              widget.categoryId,
                            );
                          } else {
                            res = await TransactionController.insert(
                              nameTransaksiController.text,
                              deskripsiTransaksiController.text,
                              int.parse(
                                  _moneyController.text.replaceAll('.', '')),
                              selectedDate,
                              widget.categoryId,
                            );
                          }
                          if (res) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavbar(initIndex: 1),
                              ),
                              (route) => false,
                            );
                            showModalInformation(
                                context,
                                'assets/images/alertYes.svg',
                                "Berhasil Diperbarui",
                                true);
                            // showSuccessAlert(context, "Berhasil!");
                          } else {
                            showModalInformation(
                                context,
                                'assets/images/alertNo.svg',
                                'Maksimum Pengeluaran Mencapai Batas! Sisa ' +
                                    TextCurrencyFormat.format(sisa.toString()),
                                true);
                            // showFailedAlert(
                            //     context,
                            //     'Maksimum Pengeluaran Mencapai Batas! Sisa ' +
                            //         TextCurrencyFormat.format(sisa.toString()));
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
