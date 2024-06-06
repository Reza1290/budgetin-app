import 'package:budgetin/controller/category_controller.dart';
import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/tracker_service.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/forms/input_money.dart';
import 'package:budgetin/widgets/forms/input_text.dart';
import 'package:budgetin/widgets/modal/budgetin_sheet.dart';
import 'package:budgetin/widgets/modal/modal_icon_kategori.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<void> showSheetCategory(BuildContext context, [Category? category]) {
  final TrackerService tracker = TrackerService();

  final TextEditingController _nameController =
      TextEditingController(text: category != null ? category.name : '');
  final TextEditingController _alokasiController = TextEditingController(
      text: category != null ? category.total.toString() : '');
  String val = category != null ? category.icon : "assets/icons/Plus.svg";
  bool isValid = true;
  final _formKey = GlobalKey<FormState>();
  Future<void> fetchCategory() async {
    Category temp = await db!.getCategory(category!.id);
    _nameController.text = temp.name;
    _alokasiController.text = temp.total.toString();
    val = temp.icon.toString();
  }

  if (category != null) {
    fetchCategory();
  }

  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    backgroundColor: BudgetinColors.hitamPutih10,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (context) {
      return BudgetinSheet(
        body: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: CustomPaint(
                      size: const Size(60, 20),
                      painter: SliderPaint(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Text(
                    category == null ? 'Tambah Kategori' : 'Edit Kategori',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textPrimary),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: BudgetinColors.biru10,
                        border: isValid
                            ? null
                            : Border.all(color: BudgetinColors.merah40),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: SvgPicture.asset(val),
                  ),
                  onTap: () async {
                    final res = await showModalIconKategori(context);
                    setState(() {
                      val = res ?? "assets/icons/Lainnya.svg";
                      isValid = true;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Pilih Ikon',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Nama Kategori',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: BudgetinColors.hitamPutih100),
                        ),
                      ),
                      InputText(
                        controller: _nameController,
                        hintText: 'Masukkan Nama Kategori',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          'Alokasi Dana',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: BudgetinColors.hitamPutih100),
                        ),
                      ),
                      InputMoney(
                        fontSize: 13,
                        controller: _alokasiController,
                        // hintText: 'Masukkan Nama Kategori',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: GestureDetector(
                          onTap: () async {
                            if (val == 'assets/icons/Plus.svg') {
                              setState(() {
                                isValid = false;
                              });
                            }
                            bool res = false;
                            if (_formKey.currentState!.validate() && isValid) {
                              if (category != null) {
                                res = await CategoryController.insert(
                                    _nameController.text,
                                    val,
                                    _alokasiController.text,
                                    category.id);
                              } else {
                                res = await CategoryController.insert(
                                    _nameController.text,
                                    val,
                                    _alokasiController.text);
                              }
                              // print('res' + res.toString());
                              if (res) {
                                Navigator.pop(context);
                                showModalInformation(
                                    context,
                                    'assets/images/alertYes.svg',
                                    'Kategori Berhasil Ditambahkan.',
                                    true);
                                tracker.track(
                                    'on-${category != null ? 'edit' : 'create'}-kategori',
                                    withDeviceInfo: true);
                              } else {
                                showModalInformation(
                                    context,
                                    'assets/images/alertNo.svg',
                                    'Alokasi Melebihi Saldo Kamu atau Dibawah Uang Terpakai.',
                                    true);
                              }
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: BudgetinColors.biru50,
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                'Simpan',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: BudgetinColors.hitamPutih10),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
