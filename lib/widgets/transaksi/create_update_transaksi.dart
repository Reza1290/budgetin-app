import 'package:budgetin/controller/transaction_controller.dart';
import 'package:budgetin/models/transaction_with_category.dart';
import 'package:budgetin/providers/tracker_service.dart';
import 'package:budgetin/widgets/bottom_navbar.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/reusable/budget_status_card.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:budgetin/widgets/reusable/new_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CreateUpdateTransaksiPage extends StatefulWidget {
  final int categoryId;
  final bool? isEditPage;
  final bool? isOnCategory;
  final TransactionWithCategory? dataTransaction;
  const CreateUpdateTransaksiPage(
      {super.key,
      required this.categoryId,
      this.isEditPage = false,
      this.isOnCategory = false,
      this.dataTransaction});

  @override
  State<CreateUpdateTransaksiPage> createState() =>
      _CreateUpdateTransaksiPageState();
}

class _CreateUpdateTransaksiPageState extends State<CreateUpdateTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final TrackerService tracker = TrackerService();
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
        scrolledUnderElevation: 0,
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: Text(
          widget.isEditPage! ? 'Edit Transaksi' : 'Tambah Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
        child: Form(
          key: _formKey,
          child: Container(
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
                        buildCalendarDialogButton(context, selectedDate, "",
                            (newDate) {
                          setState(() {
                            selectedDate = newDate;
                          });
                          print(selectedDate);
                        }),
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
                          isMandatory: false,
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
                            widget.isEditPage!
                                ? Navigator.pop(context)
                                : widget.isOnCategory!
                                    ? Navigator.pop(context)
                                    : Navigator.pushAndRemoveUntil(
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
                                "Berhasil Tersimpan",
                                true);
                            // showSuccessAlert(context, "Berhasil!");
                            tracker.track(
                                'on-${widget.isEditPage! ? 'edit' : 'create'}-transaksi',
                                withDeviceInfo: true);
                          } else {
                            showModalInformation(
                                context,
                                'assets/images/alertNo.svg',
                                'Maksimum Pengeluaran Mencapai Batas!',
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
