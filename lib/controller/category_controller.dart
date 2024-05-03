import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:budgetin/providers/currency.dart';
import 'package:drift/drift.dart';

class CategoryController {
  static insert<bool>(
    String name,
    String icon,
    String total,
  ) async {
    int saldoBulanIni = await db!.getFirstSaldo().then((value) => value!.saldo);
    int totalAlokasi = await db!.sumUsedSaldo();

    int alokasi = TextCurrencyFormat.toInt(total);
    int res = 0;
    if (saldoBulanIni >= totalAlokasi + alokasi) {
      res = await db!.insertCategory(CategoriesCompanion(
          name: Value(name), icon: Value(icon), total: Value(alokasi)));
    }

    return res > 0 ? true : false;
  }
}
