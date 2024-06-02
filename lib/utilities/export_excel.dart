import 'dart:io';

import 'package:budgetin/models/transaction_with_category.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelService {
  Future<List<int>> generateExcel(
      List<TransactionWithCategory> transactions) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('Tanggal');
    sheet.getRangeByName('B1').setText('Nama');
    sheet.getRangeByName('C1').setText('Deskripsi');
    sheet.getRangeByName('D1').setText('Kategori');
    sheet.getRangeByName('E1').setText('Jumlah');

    int rowIndex = 2;
    for (var transaction in transactions) {
      sheet
          .getRangeByName('A$rowIndex')
          .setText(transaction.transaction.transaction_date.toString());
      sheet.getRangeByName('B$rowIndex').setText(transaction.transaction.name);
      sheet
          .getRangeByName('C$rowIndex')
          .setText(transaction.transaction.description);
      sheet.getRangeByName('D$rowIndex').setText(transaction.category.name);
      sheet.getRangeByName('E$rowIndex').setNumber(double.parse(transaction
          .transaction.amount
          .toString())); // Assuming amount is numeric
      rowIndex++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }

  Future<void> savedExcelFile(String filename, List<int> bytelist) async {
    final output = (await getApplicationSupportDirectory()).path;
    final File file = File('$output/$filename.xlsx');
    await file.writeAsBytes(bytelist, flush: true);
    OpenFile.open(filename);
  }
}
