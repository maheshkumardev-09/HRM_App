import 'package:hrm_app/features/payroll/models/payroll_model.dart';
import 'package:intl/intl.dart';
import 'package:better_download_saver/better_download_saver.dart';
import 'package:pdf/widgets.dart' as pw;

class PayrollServices {
  Future<bool> createPayrollPdf(PayrollModel payroll) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: ((context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('PAYSLIP'),
                pw.SizedBox(height: 20),
                pw.Text('Payroll ID: ${payroll.id}'),
                pw.SizedBox(height: 15),
                pw.Text(
                  'From Date: ${DateFormat('dd MM yyyy').format(payroll.dateFrom)}',
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  'To Date: ${DateFormat('dd MM yyyy').format(payroll.dateTo)}',
                ),
                pw.SizedBox(height: 15),
                pw.Text('Status: ${payroll.status}'),
                pw.SizedBox(height: 15),
                pw.Text('Amount:${payroll.payment.toStringAsFixed(2)}'),
                pw.SizedBox(height: 15),
              ],
            ),
          );
        }),
      ),
    );
    try {
      final bytes = await pdf.save();
      final saver = BetterDownloadSaver();
      await saver.saveToDownloads(
        fileName: 'Payslip_${payroll.id}.pdf',
        bytes: bytes,
        mimeType: 'application/pdf',
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
