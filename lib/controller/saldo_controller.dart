import 'package:budgetin/main.dart';
import 'package:budgetin/providers/currency.dart';

class SaldoController {
  static Future<bool> simpanSaldo(int sal) async {
    int sum = await db!.sumUsedSaldo();
    bool berhasil = false;
    if (sum > sal) {
      berhasil = false;
    } else {
      await db!.createOrUpdateSaldo(sal);
      berhasil = true;
    }
    return berhasil;
  }
}
