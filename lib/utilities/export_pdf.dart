import 'dart:io';
import 'dart:typed_data';

import 'package:budgetin/models/transaction_with_category.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<Uint8List> generatePdf(
      List<TransactionWithCategory> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Center(
                child: pw.Text('Laporan Transaksi',
                    style: pw.TextStyle(fontSize: 20)),
              ),
            ),
            pw.TableHelper.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: const pw.TextStyle(),
              data: <List<String>>[
                <String>['Tanggal', 'Nama', 'Deskripsi', 'Kategori', 'Jumlah'],
                for (var transaction in transactions)
                  [
                    '${transaction.transaction.transaction_date}',
                    '${transaction.transaction.name}',
                    '${transaction.transaction.description}',
                    '${transaction.category.name}',
                    '${transaction.transaction.amount}',
                  ],
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  Future<void> savedPdfFile(String filename, Uint8List bytelist) async {
    // print("ini hanya test");
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$filename.pdf";
    final file = File(filePath);
    await file.writeAsBytes(bytelist);
    await OpenFile.open(filePath);
  }
}
