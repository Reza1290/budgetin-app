import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';

class CategoryController {
  static insert(CategoriesCompanion category) async {
    int saldoBulanIni = await db!.getFirstSaldo().then((value) => value!.saldo);
    int totalAlokasi = await db!.sumUsedSaldo();
    // sebenernya bisa perbulan reset :D gimana ya :D bentar oke done i got it
    // if(saldoBulanIni)
  }
}
