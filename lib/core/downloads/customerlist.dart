import 'storagepermission.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
/*
usage:
onPressed()
{
customerListWriteOnPdf();
}
 */

var sty1 = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16);
var sty3 = pw.TextStyle(fontSize: 20);
var sty2 = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 30);
var pdf;
customerListWriteOnPdf() async {
  await storagePermission();
  pdf = pw.Document();
  final time = DateTime.now();
  final number = 1;
  final credit = 2.00;
  final debit = 0.00;
  var fin = (credit - debit);
  if (fin < 0) fin = -fin;

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                pw.Text("MyCustomer",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 35,
                        color: PdfColors.blue)),
                pw.Column(children: [
                  pw.Text("BusinessName", style: sty1),
                  pw.Text("       Ph: +919110396669", style: sty1),
                ])
              ])),
          pw.SizedBox(
            height: 10,
            width: double.infinity,
          ),
          pw.Container(
            height: 2,
            width: double.infinity,
            color: PdfColors.black,
          ),
          pw.SizedBox(
            height: 40,
            width: double.infinity,
          ),
          pw.Container(
            child: pw.Column(children: [
              pw.Container(
                child: pw.Text("Customer List Report", style: sty2),
              ),
              pw.SizedBox(height: 40, width: double.infinity),
              pw.Row(
                  //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text("Report Generated At :", style: sty3),
                    pw.SizedBox(width: 30),
                    pw.Text("$time", style: sty1),
                  ]),
              pw.SizedBox(height: 20, width: double.infinity),
              pw.Row(
                  //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text("Number of Customers :", style: sty3),
                    pw.SizedBox(width: 18),
                    pw.Text("$number", style: sty1),
                  ]),
              pw.SizedBox(height: 20, width: double.infinity),
              pw.Row(children: [
                pw.Text("Credit :  ", style: sty3),
                pw.SizedBox(width: 165),
                pw.Text("$credit", style: sty1),
              ]),
              pw.SizedBox(height: 20, width: double.infinity),
              pw.Row(children: [
                pw.Text("Debit :  ", style: sty3),
                pw.SizedBox(width: 168),
                pw.Text("$debit", style: sty1),
              ]),
              pw.SizedBox(height: 20, width: double.infinity),
              pw.Row(children: [
                pw.Text("Final :  ", style: sty3),
                pw.SizedBox(width: 168),
                pw.Text("$fin", style: sty1),
              ]),
            ]),
          ),
          pw.SizedBox(height: 40),
          pw.Table.fromTextArray(context: context, data: <List<String>>[
            <String>['Sno', 'Name', 'Address/phone', 'Credit', 'Debit'],
            <String>['1', 'Vasanth', '91910191', '10', ''],
            <String>['2', 'Eternity', 'opopop', '39', ''],
            <String>['3', 'Naza', '0p0000', '', '100'],
            <String>['4', 'Name', 'Address/phone', 'Credit', 'Debit'],
            <String>['5', 'Name', 'Address/phone', 'Credit', 'Debit'],
            <String>['6', 'Name', 'Address/phone', 'Credit', 'Debit'],
            <String>['7', 'Name', 'Address/phone', 'Credit', 'Debit'],
            <String>['8', 'Name', 'Address/phone', 'Credit', 'Debit'],
          ]),
//          Report Generated At : 15/06/2020 09:46 pm
//          Number of Customers : 1 / 1
//          Total Amount They'll Receive : ₹ 2.00
//          Total Amount They'll Pay : ₹ 0.00
//          Final Balance :
        ];
      }));
  await savePdf();
}

Future savePdf() async {
  Directory downloadsDirectory = await getExternalStorageDirectory();
  String documentPath = downloadsDirectory.path;
  final time = DateTime.now();
  print(documentPath.toUpperCase());
  File file = File("$documentPath/transaction$time.pdf");
  print(file);
  file.writeAsBytesSync(pdf.save());
  OpenFile.open("$documentPath/transaction$time.pdf");
  pdf = null;
}
