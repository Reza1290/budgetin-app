import 'package:budgetin/controller/category_controller.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/utilities/them.dart';
import 'package:budgetin/widgets/modal/sheet_category.dart';
import 'package:budgetin/widgets/reusable/information_modal.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class DetailCategoryActions extends StatefulWidget {
  final Category category;
  const DetailCategoryActions({super.key, required this.category});

  @override
  State<DetailCategoryActions> createState() => _DetailCategoryActionsState();
}

class _DetailCategoryActionsState extends State<DetailCategoryActions> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<SampleItem>(
        surfaceTintColor: BudgetinColors.hitamPutih10,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          PopupMenuItem<SampleItem>(
            onTap: () => showSheetCategory(context, widget.category),
            value: SampleItem.itemOne,
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: BudgetinColors.biru40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Sunting',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          PopupMenuItem<SampleItem>(
            onTap: () async {
              showModalInformation(
                  context,
                  'assets/images/modal_gagal.svg',
                  "Hapus Kategori Beserta Transaksi?",
                  false, onPressed: () async {
                bool res = await CategoryController.delete(widget.category.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Tutup dialog
              });
            },
            value: SampleItem.itemTwo,
            child: Row(
              children: [
                Icon(
                  Icons.delete_forever_rounded,
                  color: BudgetinColors.merah50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Hapus',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
