import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'dart:async';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({this.path});
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path: path);
  }
}

//launch("market://details?id=<Package name>");

class GeneralTransactionReport {
  final dformat = new DateFormat('dd/MM/yyyy');
  final fformat = new DateFormat('hh:mm aa');
  final currency = new NumberFormat("#,##0", "en_NG");

  // MainTransactionViewModel model;

  Future<Uint8List> buildpdf(BuildContext context,
      {List<TransactionModel> transactions,
      String start,
      String stop,
      CustomerContact customer,
      double totaldebt,
      double totalcredit,
      String symbol}) async {
    final pdf = pw.Document();
    print('here');
    print(start +
        '' +
        stop +
        '' +
        customer.name +
        '' +
        totaldebt.toString() +
        '' +
        totalcredit.toString() +
        '' +
        transactions.length.toString());
    PdfImage image = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/app-google-play.png'))
          .buffer
          .asUint8List(),
    );

    final font = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(font);

    final fontBold = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final ttfBold = pw.Font.ttf(fontBold);

    pdf.addPage(pw.MultiPage(
      // margin: pw.EdgeInsets.symmetric(vertical: 20),
      // pageFormat: PdfPageFormat.a4,
      pageTheme: _buildTheme(PdfPageFormat.a4, ttf, ttfBold, ttf),
      footer: (pw.Context context) {
        return pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Image(image),
                  pw.Text('Page ${context.pageNumber} of ${context.pagesCount}')
                ]));
      },
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Column(
            children: <pw.Widget>[
              pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Container(
                      margin: pw.EdgeInsets.only(bottom: 40),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.RichText(
                            text: pw.TextSpan(
                              style: pw.TextStyle(
                                  color: PdfColors.black, fontSize: 24),
                              children: <pw.TextSpan>[
                                pw.TextSpan(
                                    text: 'CustomerPayMe',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 24)),
                              ],
                            ),
                          ),
                          pw.Column(
                            children: <pw.Widget>[
                              pw.Text(customer.name,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                      fontSize: 18)),
                              pw.Text(customer.phoneNumber.replaceAll(' ', ''),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                      fontSize: 18))
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Container(
                          margin: pw.EdgeInsets.only(bottom: 15),
                          child: pw.Text(
                            'Transactions Report : ( ' +
                                start +
                                ' - ' +
                                stop +
                                ' )',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        pw.Text(
                            'Report Generated at :               ' +
                                dformat.format(DateTime.now()).toString() +
                                ' ' +
                                fformat.format(DateTime.now()).toString(),
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 15)),
                        pw.Text(
                            'Transaction ID :                         0001-0001',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 15)),
                        pw.Text('Number of Customers :            1',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 15)),
                        pw.Row(
                          children: <pw.Widget>[
                            pw.Text(
                                'Total Paid :                                  ',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 15)),
                            pw.Text(
                              symbol + '${currency.format(totaldebt)}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 15,
                                color: PdfColor.fromHex('21D184'),
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: <pw.Widget>[
                            pw.Text(
                                'Total Debt :                                 ',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 15)),
                            pw.Text(
                              symbol + '${currency.format(totalcredit)}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 15,
                                color: PdfColor.fromHex('E52D27'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.only(top: 20, bottom: 20),
                      child: pw.Text('Customer : ' + customer.name,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 18)),
                    ),
                  ],
                ),
              ),
              pw.Container(
                  width: 620, //420
                  padding: pw.EdgeInsets.symmetric(vertical: 20),
                  color: PdfColors.grey300,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: <pw.Widget>[
                        pw.Container(
                          //color: PdfColors.red,
                          width: 70,
                          child: pw.Center(
                            child: pw.Text(
                              'S.No',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex('333CC1')),
                            ),
                          ),
                        ),
                        pw.Container(
                          width: 150,
                          //color: PdfColors.red,
                          child: pw.Center(
                            child: pw.Text(
                              'Date',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex('333CC1')),
                            ),
                          ),
                        ),
                        pw.Container(
                          width: 150,
                          child: pw.Center(
                            child: pw.Text(
                              'Description',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex('333CC1')),
                            ),
                          ),
                        ),
                        pw.Container(
                          //color: PdfColors.red,
                          width: 100,
                          child: pw.Center(
                            child: pw.Text(
                              'Paid',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex('333CC1')),
                            ),
                          ),
                        ),
                        pw.Container(
                          width: 100,
                          //color: PdfColors.red,
                          child: pw.Center(
                            child: pw.Text(
                              'Debt',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex('333CC1')),
                            ),
                          ),
                        ),
                      ])),
              for (var item in transactions)
                pw.Container(
                    width: 620,
                    padding: pw.EdgeInsets.symmetric(vertical: 20),
                    color: transactions.indexOf(item) % 2 == 0
                        ? PdfColors.grey100
                        : PdfColors.white,
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: <pw.Widget>[
                          pw.Container(
                              width: 70,
                              //color: PdfColors.red,
                              child: pw.Center(
                                  child: pw.Text(
                                      (transactions.indexOf(item) + 1)
                                          .toString(),
                                      style: pw.TextStyle(fontSize: 14)))),
                          pw.Container(
                              width: 150,
                              //color: PdfColors.red,
                              child: pw.Center(
                                child: pw.Text(
                                    item.amount > item.paid
                                        ? dformat
                                                .format(DateTime.parse(
                                                    item.boughtdate))
                                                .toString() +
                                            '\n' +
                                            fformat
                                                .format(DateTime.parse(
                                                    item.boughtdate))
                                                .toString()
                                        : dformat
                                                .format(DateTime.parse(
                                                    item.paiddate))
                                                .toString() +
                                            '\n' +
                                            fformat
                                                .format(DateTime.parse(
                                                    item.paiddate))
                                                .toString(),
                                    style: pw.TextStyle(fontSize: 14),
                                    textAlign: pw.TextAlign.center),
                              )),
                          pw.Container(
                              width: 150,
                              child: pw.Center(
                                child: pw.Text(item.description ?? '',
                                    style: pw.TextStyle(fontSize: 14)),
                              )),
                          pw.Container(
                              width: 100,
                              child: pw.Center(
                                child: pw.Text(
                                    item.amount == 0
                                        ? ''
                                        : symbol +
                                            '${currency.format(item.amount)}',
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        color: PdfColor.fromHex('21D184'))),
                              )),
                          pw.Container(
                              width: 100,
                              child: pw.Center(
                                child: pw.Text(
                                    item.paid == 0
                                        ? ''
                                        : symbol +
                                            '${currency.format(item.paid)}',
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        color: PdfColor.fromHex('E52D27'))),
                              )),
                        ])),
              pw.Container(
                width: 620,
                padding: pw.EdgeInsets.symmetric(vertical: 20),
                color: PdfColors.grey300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: <pw.Widget>[
                    pw.Container(
                        //color: PdfColors.red,
                        width: 220,
                        child: pw.SizedBox()),
                    pw.Container(
                      width: 150,
                      child: pw.Center(
                        child:
                            pw.Text('Total', style: pw.TextStyle(fontSize: 14)),
                      ),
                    ),
                    pw.Container(
                      width: 100,
                      child: pw.Center(
                        child: pw.Text(
                          symbol + '${currency.format(totaldebt)}',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColor.fromHex('21D184')),
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 100,
                      //color: PdfColors.red,
                      child: pw.Center(
                        child: pw.Text(
                          symbol + '${currency.format(totalcredit)}',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColor.fromHex('E52D27')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ];
      },
    ));

    return pdf.save();
    //save pdf(context, pdf);
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      margin: pw.EdgeInsets.symmetric(vertical: 20),
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  Future savepdf(BuildContext context, Uint8List pdf) async {
    Directory doc = await getExternalStorageDirectory();
    Directory dic = await getExternalStorageDirectory();
    String docdir = doc.path;
    String docdic = dic.path;
    String time = DateTime.now().microsecondsSinceEpoch.toString();
    print(docdir);
    //String patth = "$docdic/report"+time+".pdf";
    File file = File("$docdir/exampll.pdf");
    File filet = new File("$docdic/report" + time + ".pdf");
    filet.writeAsBytes(pdf);
    file.writeAsBytesSync(pdf);
    OpenFile.open(filet.path);
    //flusher('Report has been saved at '+filet.path, context);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => PdfViewerPage(path: filet.path),
    //   ),
    // );
  }
}
