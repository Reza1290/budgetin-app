import 'package:budgetin/main.dart';
import 'package:budgetin/providers/currency.dart';

class SaldoController {
  static simpanSaldo<bool>(int sal) async {
    int sum = await db!.sumUsedSaldo();
    if (sum > sal) {
      return false;
    } else {
      await db!.createOrUpdateSaldo(sal);
      return true;
    }
  }
}
