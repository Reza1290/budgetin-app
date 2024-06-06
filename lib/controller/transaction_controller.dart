import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';

class TransactionController {
  static insert<bool>(String name, String description, int amount,
      DateTime date, int categoryId) async {
    print('tanggal' + date.toString());
    try {
      DateTime newDate = DateTime(date.year, date.month, date.day, 12, 0);
      int maks = await db!.sumExpenseCategory(categoryId);
      Category category = await db!.getCategory(categoryId);

      if (maks + amount > category.total) {
        return false;
      }

      await db!.into(db!.transactions).insertReturning(
            TransactionsCompanion.insert(
                name: name,
                description: description,
                category_id: categoryId,
                amount: amount,
                transaction_date: newDate),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  static update<bool>(int prevAmount, String name, String description,
      int amount, DateTime date, int transactionId, int categoryId) async {
    try {
      DateTime newDate = DateTime(date.year, date.month, date.day, 12, 0);
      // date = date
      int maks = await db!.sumExpenseCategory(categoryId);
      Category category = await db!.getCategory(categoryId);
      if (maks + amount - prevAmount <= category.total) {
        db!.updateTransactionRepo(
            transactionId, name, amount, categoryId, description, newDate);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
