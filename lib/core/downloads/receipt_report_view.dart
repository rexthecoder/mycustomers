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
  final format = DateFormat.yMMMd('en_US');
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

  PdfImage _image;

  Future<Uint8List> buildPdf(BuildContext context) async {
    await storagePermission();
    doc = pw.Document();

    _image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/receiptLogo.png'))
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
                        child: pw.Image(_image),
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
                    pw.Text(
                      'myCustomer',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      _formatDate(DateTime.now()),
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 15),
                    //TODO: Put a count on #00001
                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'R e p o r t ',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 15,
                        ),
                        children: [
                          pw.TextSpan(
                            text: ' # 0 0 0 0 1',
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
                                pw.Text(
                                  'HNG Inc',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'HNG Headquarters,',
                                  style: pw.TextStyle(
                                    fontSize: 6,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  '2020 Hamilton Avenue,',
                                  style: pw.TextStyle(
                                    fontSize: 6,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  'San jose, california 95125',
                                  style: pw.TextStyle(
                                    fontSize: 6,
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
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'Design a recommendation job portal including a 5 page',
                                  style: pw.TextStyle(
                                    fontSize: 6,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  'Landing page and the admin dashboard',
                                  style: pw.TextStyle(
                                    fontSize: 6,
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
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Deliverable',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(height: 10),
                                      pw.Text(
                                        'Initial Research & Web Application '
                                        'Design Sketch File',
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text(
                                        '2020 Hamilton Avenue,',
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text(
                                        'San jose, california 95125',
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  //margin:
                                  //pw.EdgeInsets.only(left: 70, right: 70),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.SizedBox(
                                        height: 17.5,
                                      ),
                                      pw.Text(
                                        '---------------------------',
                                        style: pw.TextStyle(
                                          color: PdfColors.grey,
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 0.5,
                                      ),
                                      pw.Text(
                                        '---------------------------',
                                        style: pw.TextStyle(
                                          color: PdfColors.grey,
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 0.5,
                                      ),
                                      pw.Text(
                                        '---------------------------',
                                        style: pw.TextStyle(
                                          color: PdfColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.only(right: 30),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        'Pricing',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(height: 10),
                                      pw.Text(
                                        _formatCurrency(5000),
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text(
                                        _formatCurrency(1200),
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text(
                                        _formatCurrency(2500),
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ],
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
                            padding: pw.EdgeInsets.only(
                                left: 30, top: 10, bottom: 10, right: 30),
                            color: PdfColor.fromInt(0xFF333CC1),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Total',
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        _formatCurrency(8700),
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.white,
                                        ),
                                      ),
                                    ],
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
                            padding: pw.EdgeInsets.only(
                                left: 30, top: 10, bottom: 10, right: 40),
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  child: pw.Container(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          'Bank Transfer Details',
                                          style: pw.TextStyle(
                                            fontSize: 6,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        pw.SizedBox(
                                          height: 5,
                                        ),
                                        pw.Row(
                                          mainAxisSize: pw.MainAxisSize.max,
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'Account Name:',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                            pw.Text(
                                              'Salako Ibrahim',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.SizedBox(
                                          height: 5,
                                        ),
                                        pw.Row(
                                          mainAxisSize: pw.MainAxisSize.max,
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'Bank Name:',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                            pw.Text(
                                              'FCMB',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.SizedBox(
                                          height: 5,
                                        ),
                                        pw.Row(
                                          mainAxisSize: pw.MainAxisSize.max,
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'Account No:',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                            pw.Text(
                                              '3021 200 3622',
                                              style: pw.TextStyle(
                                                fontSize: 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 120,
                                ),
                                pw.Container(
                                  //TODO: Move this to Top Container
                                  width: 110,
                                  height: 35,
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Notes',
                                        style: pw.TextStyle(
                                          fontSize: 6,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.RichText(
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        maxLines: 2,
                                        text: pw.TextSpan(
                                          text:
                                              'All deposits to be made within 7 days'
                                              ' of receipt',
                                          style: pw.TextStyle(
                                            fontSize: 6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
