import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:drift/drift.dart';

class CategoryController {
  static insert<bool>(String name, String icon, String total, [int? id]) async {
    int saldoBulanIni = await db!.getFirstSaldo().then((value) => value!.saldo);
    int totalAlokasi = await db!.sumUsedSaldo();
    int totalCategoryNow = 0;
    if (id != null) {
      totalCategoryNow = await db!.getCategory(id).then((value) => value.total);
    }

    int alokasi = TextCurrencyFormat.toInt(total);
    int res = 0;
    print(saldoBulanIni);
    print((saldoBulanIni >= totalAlokasi + alokasi).toString());
    if (saldoBulanIni >= totalAlokasi + alokasi && id == null) {
      res = await db!.insertCategory(CategoriesCompanion(
          name: Value(name), icon: Value(icon), total: Value(alokasi)));
    } else if (id != null &&
        saldoBulanIni >= totalAlokasi - totalCategoryNow + alokasi) {
      print("HALO DEK");
      return await db!.updateCategory(CategoriesCompanion(
          id: Value(id),
          name: Value(name),
          icon: Value(icon),
          total: Value(alokasi)));
    }

    return res > 0 ? true : false;
  }

  static delete<bool>(int id) async {
    return db!.deleteCategory(id);
  }
}
