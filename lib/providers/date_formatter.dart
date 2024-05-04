import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanReadableDateFormatter {
  static String format(DateTime dateTime) {
    initializeDateFormatting('id');

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 7) {
      return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
    } else if (difference.inDays >= 2) {
      return DateFormat('EEEE, dd MMMM yyyy', 'id').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inHours == 1) {
      return 'Satu jam yang lalu';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  static formatToDate(DateTime dateTime) {
    initializeDateFormatting('id');
    return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
  }

  static String dateNowFormatter(DateTime value) {
    initializeDateFormatting('id');
    return DateFormat('EEEE, dd MMMM yyyy', 'id').format(value);
  }

  static String dateMonthFormatter(DateTime value) {
    initializeDateFormatting('id');
    return DateFormat('MMMM', 'id').format(value);
  }
}
