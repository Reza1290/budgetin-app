import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/budgetin_modal.dart';
import 'package:budgetin/widgets/reusable/newCalender.dart';
import 'package:budgetin/widgets/reusable/rangeDate.dart';
import 'package:budgetin/widgets/reusable/title_modal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];


  late String? _selectedValue;
  late DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDate2 = DateTime.now();
  // late DateTime _selectedDateEnd = DateTime.now();

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // selectedDate = DateTime.now();
    // selectedDateEnd = DateTime.now();
    _selectedValue = items
        .first; // Inisialisasi _selectedValue dengan nilai pertama dari items
  }

  @override
  Widget build(BuildContext context) {
    return BudgetinModal(
      title: TitleModal(title: 'Filter Transaksi'),
      content: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 6),
              child: const Text(
                "Kategori",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Pilih Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),

                iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                    ),
                    openMenuIcon: Transform.rotate(
                      angle: 3,
                      child: Icon(Icons.arrow_drop_down_rounded),
                    )),
                items: items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xFFD1D1D1),
                      ),
                    )),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Cari berdasarkan nama..',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          // Menambahkan border
                          borderRadius: BorderRadius.circular(
                              6.0), // Mengatur sudut border
                          borderSide: BorderSide(
                              color: Color(0xFFD1D1D1)), // Mengatur sisi border
                        ),
                        focusedBorder: OutlineInputBorder(
                          // Mengubah warna border ketika aktif menjadi biru
                          borderRadius: BorderRadius.circular(
                              6.0), // Mengatur sudut border
                          borderSide: BorderSide(
                              color:
                                  Color(0xFF1D77FF)), // Mengatur warna border
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 6),
              child: Text(
                "Rentang Tanggal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),

           RangeDate(),
          ],
        ),
      ),
      actions: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selectedValue = null;
                    _selectedDate = DateTime.now();
                    
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      BudgetinColors.hitamPutih30),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(
                        2), // Atur padding di sini sesuai kebutuhan Anda
                  ),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: BudgetinColors.hitamPutih50,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  // Apply filter logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(BudgetinColors.biru50),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(
                        2), // Atur padding di sini sesuai kebutuhan Anda
                  ),
                ),
                child: Text(
                  'Terapkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: BudgetinColors.hitamPutih10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showModalFilter(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return FilterDialog();
    },
  );
}
