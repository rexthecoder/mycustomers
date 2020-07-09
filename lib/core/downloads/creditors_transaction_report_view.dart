import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/downloads/red.dart';
import 'package:mycustomers/main.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/settings/saved_dialog_modal/saved_dialog_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'creditors_transaction_report_viewmodel.dart';

class CreditorsTransactionReportView extends StatelessWidget {
  final pdf = pw.Document();
  // const PdfColor

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditorsTransactionReportViewModel>.reactive(
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
                  Report().buildPdf(context);
                },
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CreditorsTransactionReportViewModel(),
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

class Report {
  // private 'image' of type PdfImage
  PdfImage _image;

  // List of type 'Data'
  final List<Data> dataBody = [
    Data(1, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(2, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(3, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(4, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(5, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(6, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(7, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(8, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(9, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(10, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(11, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(12, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(13, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(14, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    Data(15, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
  ];

  Future<Uint8List> buildPdf(BuildContext context) async {
    final doc = pw.Document();

    _image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/icons/my_customer_logo.png'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentBody(context),
          //_contentFooter(context),
        ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/report.pdf';
    final File file = File(path);
    await file.writeAsBytes(doc.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );

    //TODO: Return the PDF file content
    // return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    //TODO: Add margin to both _buildHeader & _contentBody
    return pw.Row(
      children: <pw.Widget>[
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Container(
                width: 150.0,
                height: 200.0,
                child: pw.Image(_image),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Container(
                //TODO: change to date generated and color to grey
                child: pw.Text(
                  '25th June, 2020.',
                  style: pw.TextStyle(
                    color: PdfColors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Container(
                    child: pw.Text(
                      "Monthly Report",
                      style: pw.TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  pw.Container(
                    //TODO: change from hardcoded data
                    child: pw.Text(
                      "@BioChris",
                      style: pw.TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Divider(
                color: PdfColors.black,
                height: 10.0,
                thickness: 1.0,
              ),
              pw.SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Row(
          children: <pw.Widget>[
            pw.Container(
              width: 150.0,
              height: 200.0,
              child: pw.Image(_image),
            ),
          ],
        ),
        pw.Container(
          color: PdfColors.blue,
          padding: pw.EdgeInsets.all(7),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            mainAxisSize: pw.MainAxisSize.max,
            children: <pw.Widget>[
              pw.Container(
                child: pw.RichText(
                  text: pw.TextSpan(
                    children: <pw.TextSpan>[
                      pw.TextSpan(
                        text: 'https://mycustomer.io',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Container(
                child: pw.RichText(
                  text: pw.TextSpan(
                    children: <pw.TextSpan>[
                      pw.TextSpan(
                        text: 'Page 1 of 1',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentBody(pw.Context context) {
    //TODO: set to type <String>
    const tableHeaders = [
      'S/N',
      'Customer Name',
      'Date',
      'Remark',
      'Credit',
      'Debit',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(
        // borderRadius: 2,
        color: PdfColors.blue,
      ),
      headerHeight: 30,
      cellHeight: 40,
      //TODO: how does cellAlignments work
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: 1,
        ),
      ),
      headers: List.generate(
        tableHeaders.length,
        (headerTitle) => tableHeaders[headerTitle],
      ),
      // TODO: check <List<String>> function
      data: List.generate(
        dataBody.length,
        (row) => List.generate(
          tableHeaders.length,
          (bodyItems) => dataBody[row].getIndex(bodyItems), // getting the items
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    const tableFooter = [
      'Total',
      'Balance',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(
        // borderRadius: 2,
        color: PdfColors.blue,
      ),
      headerHeight: 30,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: 1,
        ),
      ),
      data: null,
    );
  }
}
/*Future<Uint8List> reportView(context) async {

  final doc = pw.Document();

  final data = <Data>[
    Data('1', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('2', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('3', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('4', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('5', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('6', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('7', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('8', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('9', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
    Data('10', 'Demola', 'Today', '23.0', '25.02', 'Saved'),
  ];

  const tableHeaders = [
    'S/N',
    'Customer Name',
    'Date',
    'Remark',
    'Credit',
    'Debit',
  ];

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(doc.save());
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );

  return doc.save();

}

class Report {
  PdfImage _image;

  buildPdf(context) async {
    final doc = pw.Document();

    _image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/icons/my_customer_logo.png'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: _buildHeader,
        //footer: ,
        build: (context) => [],
      ),
    );

    // return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Container(
              width: 150.0,
              height: 200.0,
              child: pw.Image(_image),
            ),
            pw.SizedBox(
              height: 20.0,
            ),
            pw.Container(
              //TODO: change to date generated and color to grey
              child: pw.Text(
                '25th June, 2020.',
                style: pw.TextStyle(
                  color: PdfColors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            pw.SizedBox(
              height: 20.0,
            ),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Container(
                  child: pw.Text(
                    "Monthly Report",
                    style: pw.TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                pw.Container(
                  //TODO: change from hardcoded data
                  child: pw.Text(
                    "@BioChris",
                    style: pw.TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            pw.Divider(
              color: PdfColors.black,
              height: 10.0,
              thickness: 1.0,
            ),
            pw.SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ],
    );
  }
}*/

/*pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return pw.Row(
        children: <pw.Widget>[
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 150.0,
                  height: 200.0,
                  child: pw.Image(image),
                ),
                pw.SizedBox(
                  height: 20.0,
                ),
                pw.Container(
                  //TODO: change to date generated and color to grey
                  child: pw.Text(
                    '25th June, 2020.',
                    style: pw.TextStyle(
                      color: PdfColors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 20.0,
                ),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Container(
                      child: pw.Text(
                        "Monthly Report",
                        style: pw.TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    pw.Container(
                      //TODO: change from hardcoded data
                      child: pw.Text(
                        "@BioChris",
                        style: pw.TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Divider(
                  color: PdfColors.black,
                  height: 10.0,
                  thickness: 1.0,
                ),
                pw.SizedBox(
                  height: 10.0,
                ),
                pw.Table.fromTextArray(
                  border: null,
                  cellAlignment: pw.Alignment.centerRight,
                  headerDecoration: pw.BoxDecoration(
                    borderRadius: 2,
                    color: PdfColors.blue,
                  ),
                  headerHeight: 25,
                  cellHeight: 40,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.center,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                  },
                  headerStyle: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 10,
                  ),
                  cellStyle: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 10,
                  ),
                  rowDecoration: pw.BoxDecoration(
                    border: pw.BoxBorder(
                      bottom: true,
                      color: PdfColors.black,
                      width: 1,
                    ),
                  ),
                  headers: List<String>.generate(
                    tableHeaders.length,
                        (col) => tableHeaders[col],
                  ),
                  data: List<List<String>>.generate(
                    data.length,
                        (row) => List<String>.generate(
                      tableHeaders.length,
                          (col) => data[row].getIndex(col),
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 150,
                ),
                pw.Container(
                  width: 150.0,
                  height: 200.0,
                  child: pw.Image(image),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  mainAxisSize: pw.MainAxisSize.max,
                  children: <pw.Widget>[
                    pw.Expanded(
                      child: pw.Container(
                        color: PdfColors.blue,
                        child: pw.RichText(
                          text: pw.TextSpan(
                            children: <pw.TextSpan>[
                              pw.TextSpan(
                                children: <pw.TextSpan>[
                                  pw.TextSpan(
                                    text: 'https://mycustomer.io',
                                    style: pw.TextStyle(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: 'Page 1 of 1',
                                    style: pw.TextStyle(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  ),*/
/*pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'S/N',
      'Customer Name',
      'Date',
      'Remark',
      'Credit',
      'Debit',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        // color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        data.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => data[row].getIndex(col),
        ),
      ),
    );
  }*/
