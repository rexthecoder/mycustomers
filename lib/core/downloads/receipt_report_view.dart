import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'storagepermission.dart';

import 'receipt_report_viewmodel.dart';

class ReceiptReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReceiptReportViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("PDF"),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Get Report',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blue,
                onPressed: () {
                  ReceiptReport().buildPdf(context);
                },
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ReceiptReportViewModel(),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      path: path,
    );
  }
}

String _formatDate(DateTime date) {
  //TODO: Update to accept transaction time
  final format = DateFormat.yMMMMEEEEd('en_US');
  return format.format(date);
}

String _formatCurrency(double amount) {
  return '\N${amount.toStringAsFixed(2)}';
}

class ReceiptReport {
  var updatedDt;

  ReceiptReport() {
    var dt = DateTime.now();
    updatedDt = DateFormat.Hms().format(dt);
  }

  var doc;

  PdfImage _receiptLogo;
  PdfImage _mainLogo;

  Future<Uint8List> buildPdf(BuildContext context) async {
    await storagePermission();
    doc = pw.Document();

    _receiptLogo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/receiptLogo.png'))
          .buffer
          .asUint8List(),
    );

    _mainLogo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/icons/my_customer_logo.png'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: <pw.Widget>[
              /// Background
              pw.Center(
                child: pw.Container(
                  foregroundDecoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFF8FAFA),
                  ),
                ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Container(
                        margin: pw.EdgeInsets.only(bottom: 30),
                        width: 250,
                        height: 250,
                        child: pw.Image(_receiptLogo),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                margin: pw.EdgeInsets.only(
                    right: 50, top: 25, left: 50, bottom: 80),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                          child: pw.Image(
                            _mainLogo,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      //TODO: Use date of transaction here
                      _formatDate(DateTime.now()),
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 15),
                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'Single Transaction Details: ',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            //TODO: Add transaction ID
                            text: '',
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                margin: pw.EdgeInsets.only(
                    right: 50, top: 150, left: 50, bottom: 120),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                ),
                child: pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  children: <pw.Widget>[
                    pw.Expanded(
                      child: pw.Column(
                        mainAxisSize: pw.MainAxisSize.max,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            margin: pw.EdgeInsets.only(
                                top: 25, left: 30, bottom: 25),
                            child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                //TODO: Populate with live data customer
                                // store name and address
                                pw.Text(
                                  'HNG Inc',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'HNG Headquarters,',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  '2020 Hamilton Avenue,',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  'San jose, california 95125',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: PdfColor.fromInt(0xFFC4C4C4),
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.only(
                                top: 25, left: 30, bottom: 25),
                            child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Description',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'MyCustomer is a ledger managing service '
                                  'and app that helps you manage debts ',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(left: 30, right: 30),
                            //TODO: Create a class and Populate with
                            // live data
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Items purchased:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      //TODO: Enter live items here
                                      'None',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Cost of Items:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      _formatCurrency(5000),
                                      style: pw.TextStyle(
                                        color: PdfColor.fromInt(0xFF333CC1),
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Paid:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      _formatCurrency(0),
                                      style: pw.TextStyle(
                                        color: PdfColors.green,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Owing:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      _formatCurrency(5000),
                                      style: pw.TextStyle(
                                        color: PdfColors.red,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Owed:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      _formatCurrency(0),
                                      style: pw.TextStyle(
                                        color: PdfColors.red,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ], // _contentBody(context),
                            ),
                          ),
                          pw.SizedBox(
                            height: 60,
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(
                                left: 30, top: 10, bottom: 10, right: 30),
                            color: PdfColor.fromInt(0xFF333CC1),
                          ),
                          pw.Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: PdfColor.fromInt(0xFFC4C4C4),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.center,
                            padding: pw.EdgeInsets.all(30),
                            child: pw.Image(
                              _mainLogo,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(bottom: 40, right: 190),
                    child: pw.Text(
                      'THANK YOU FOR YOUR PATRONAGE!',
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColor.fromInt(0xFF1D6AFF),
                      ),
                    ),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.only(
                        left: 50, right: 50, bottom: 15, top: 15),
                    color: PdfColor.fromInt(0xFF333CC1),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'myCustomer',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        pw.Column(
                          children: [
                            pw.Text(
                              'www.mycustomer.com',
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 6,
                              ),
                            ),
                            pw.Text(
                              'me@mycustomer.com',
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await generateReport(context);
  }

  Future<void> generateReport(BuildContext context) async {
    final Directory appDocDir = await getExternalStorageDirectory();
    final String appDocPath = appDocDir.path;
    final String path = '$appDocPath/report' + updatedDt + '.pdf';
    File file = File(path);
    print('Save as file ${file.path} ...');
    file.writeAsBytesSync(doc.save());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }
}

class ContentData {
  //TODO: create a function with a loop to do live data
  var tID; // Transaction ID
  var customerName = 'Demola'; // Customer name
  var storeName = 'DemolaStores'; // Store name
  var storeAddress = 'No.1, Not Available drive'; // Store name
  var debtor = '';
  var creditor = '';
}

class DataHandling {}
