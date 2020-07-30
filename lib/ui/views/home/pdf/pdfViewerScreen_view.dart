import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
// import 'package:stacked/stacked.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:mycustomers/core/pdf/storagepermission.dart';


import 'dart:async';
import 'dart:io';





import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';



class PdfViewerPage extends StatelessWidget {
  final String path;
 const PdfViewerPage({this.path});
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path:path
    );
  }
}

class GeneralTransactionReport {
  
  final dformat = new DateFormat('dd/MM/yyyy');
  final fformat = new DateFormat('hh:mm aa');
  final currency = new NumberFormat("#,##0", "en_NG");
  // MainTransactionViewModel model;

  Future<Uint8List> buildpdf(BuildContext context, {List<TransactionModel> transactions, String start, String stop, CustomerContact customer, double totaldebt, double totalcredit, String symbol})async{
    final pdf = pw.Document();
    print('here');
    print(start+''+stop+''+customer.name+''+totaldebt.toString()+''+totalcredit.toString()+''+transactions.length.toString());
    PdfImage image = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/app-google-play.png')).buffer.asUint8List(),
    );

    final font = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(font);

    final fontBold = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final ttfBold = pw.Font.ttf(fontBold);

    pdf.addPage(
      pw.MultiPage(
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
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}'
                )
              ]
            )
          );
        },
        build: (pw.Context context) {
          return <pw.Widget> [
            pw.Column(
              children: <pw.Widget>[
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget> [
                      pw.Container(
                        margin: pw.EdgeInsets.only(bottom: 40),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget> [
                            pw.RichText(
                              text: pw.TextSpan(
                                  style: pw.TextStyle(color: PdfColors.black, fontSize: 24),
                                  children: <pw.TextSpan>[
                                    pw.TextSpan(
                                      text: 'myCustomer',
                                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)
                                    ),
                                    pw.TextSpan(
                                      text: '.',
                                      style: pw.TextStyle(color: PdfColors.blue, fontWeight: pw.FontWeight.bold, fontSize: 30)
                                    ),
                                  ],
                              ),
                            ),
                            pw.Column(
                              children: <pw.Widget>[
                                pw.Text(
                                  customer.name,
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 18)
                                ),
                                pw.Text(
                                  customer.phoneNumber.replaceAll(' ', ''),
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 18)
                                )
                              ],
                            )
                          ]
                        ),
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Container(
                            margin: pw.EdgeInsets.only(bottom: 15),
                            child: pw.Text(
                              'Transations Report  ( '+start+' - ' +stop+' )',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)
                            ),
                          ),
                          pw.Text(
                            'Report Generated at :           '+dformat.format(DateTime.now()).toString()+' '+fformat.format(DateTime.now()).toString(),
                            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15)
                          ),
                          pw.Text(
                            'Transaction ID :                     0001-0001',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15)
                          ),
                          pw.Text(
                            'Number of Customers  :        1',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15)
                          ),
                          pw.Row(
                            children: <pw.Widget> [
                              pw.Text(
                                'Total Received  :                    ',
                                style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15)
                              ),
                              pw.Text(
                                symbol+'${currency.format(totaldebt)}',
                                style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15, color: PdfColor.fromHex('21D184'))
                              ),
                            ]
                          ),
                          pw.Row(
                            children: <pw.Widget> [
                              pw.Text(
                                'Total Gave  :                          ',
                                style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15)
                              ),
                              pw.Text(
                                symbol+'${currency.format(totalcredit)}',
                                style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15, color: PdfColor.fromHex('E52D27'))
                              ),
                            ]
                          ),
                        ],
                      ),
                      pw.Container(
                        margin: pw.EdgeInsets.only(top: 20, bottom: 20),
                        child: pw.Text(
                          'Customer : '+customer.name,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)
                        ),
                      )
                    ]
                  )
                ),
                pw.Container(
                  width: 620,//420
                  padding: pw.EdgeInsets.symmetric(vertical: 20),
                  color: PdfColors.grey300,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: <pw.Widget> [
                      pw.Container(
                        //color: PdfColors.red,
                        width: 70,
                        child: pw.Center(
                          child: pw.Text(
                            'S.No',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('333CC1')),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 150,
                        //color: PdfColors.red,
                        child: pw.Center(
                          child: pw.Text(
                            'Date',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('333CC1')),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 150,
                        child: pw.Center(
                          child: pw.Text(
                            'Note',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('333CC1')),
                          ),
                        ),
                      ),
                      pw.Container(
                        //color: PdfColors.red,
                        width: 100,
                        child: pw.Center(
                          child: pw.Text(
                            'Recieved',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('333CC1')),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 100,
                        //color: PdfColors.red,
                        child: pw.Center(
                          child: pw.Text(
                            'Gave',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('333CC1')),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
                for(var item in transactions) pw.Container(
                  width: 620,
                  padding: pw.EdgeInsets.symmetric(vertical: 20),
                  color: transactions.indexOf(item) % 2 == 0 ? PdfColors.grey100 : PdfColors.white,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: <pw.Widget> [
                      pw.Container(
                        width: 70,
                        //color: PdfColors.red,
                        child: pw.Center(
                          child: pw.Text(
                            (transactions.indexOf(item)+1).toString(),
                            style: pw.TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      pw.Container(
                        width: 150,
                        //color: PdfColors.red,
                        child: pw.Center(
                          child: pw.Text(
                            item.amount > item.paid ? dformat.format(DateTime.parse(item.boughtdate)).toString()+'\n'+fformat.format(DateTime.parse(item.boughtdate)).toString() : dformat.format(DateTime.parse(item.paiddate)).toString()+'\n'+fformat.format(DateTime.parse(item.paiddate)).toString(),
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.center
                          ),
                        )
                      ),
                      // pw.Container(
                      //   width: 100,
                      //   child: pw.Center(
                      //     child: pw.Text(
                      //       'Seyi Onifade'
                      //     ),
                      //   )
                      // ),
                      pw.Container(
                        width: 150,
                        child: pw.Center(
                          child: pw.Text(
                            item.description ?? '',
                            style: pw.TextStyle(fontSize: 14)
                          ),
                        )
                      ),
                      pw.Container(
                        width: 100,
                        child: pw.Center(
                          child: pw.Text(
                            item.amount == 0 ? '' : symbol+'${currency.format(item.amount)}',
                            style: pw.TextStyle(fontSize: 14,color: PdfColor.fromHex('21D184'))
                          ),
                        )
                      ),
                      pw.Container(
                        width: 100,
                        child: pw.Center(
                          child: pw.Text(
                            item.paid == 0 ? '' : symbol+'${currency.format(item.paid)}',
                            style: pw.TextStyle(fontSize: 14,color: PdfColor.fromHex('E52D27'))
                          ),
                        )
                      ),
                    ]
                  )
                ),
                pw.Container(
                  width: 620,
                  padding: pw.EdgeInsets.symmetric(vertical: 20),
                  color: PdfColors.grey300,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: <pw.Widget> [
                      pw.Container(
                        //color: PdfColors.red,
                        width: 220,
                        child: pw.SizedBox()
                      ),
                      pw.Container(
                        width: 150,
                        child: pw.Center(
                          child: pw.Text(
                            'Total',
                            style: pw.TextStyle(fontSize: 14)
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 100,
                        child: pw.Center(
                          child: pw.Text(
                            symbol+'${currency.format(totaldebt)}',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('21D184')),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 100,
                        //color: PdfColors.red,
                        child: pw.Center(
                          child: pw.Text(
                            symbol+'${currency.format(totalcredit)}',
                            style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('E52D27')),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
              ]
            ),
          ];
        },
      )
    );

    return pdf.save();
    //savepdf(context, pdf);
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

  Future savepdf(BuildContext context, Uint8List pdf) async{
    Directory doc = await getExternalStorageDirectory();
    Directory dic = await getExternalStorageDirectory();
    String docdir = doc.path;
    String docdic = dic.path;
    String time = DateTime.now().microsecondsSinceEpoch.toString();
    print(docdir);
    //String patth = "$docdic/report"+time+".pdf";
    File file = File("$docdir/exampll.pdf");
    File filet = new File("$docdic/report"+time+".pdf");
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


// buildPdf(BuildContext context)async {
//     await storagePermission();

//   document.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       header: _buildHeader,
//       footer: _buildFooter,
//       build:(context)=>[
//         _buildContentHeader(context),
//         pw.SizedBox(height: 25),
//         _buildContent(context),
//         pw.SizedBox(height: 20),
//         _contentTableHeader(context),
//         _contentTable(context),
//         _contentTableFooter(context)

//       ]
//       )
//   );

//  await generateReport(context);

// }

final List<FooterData> footerBody = [
    FooterData(100.0, 100.0),
  ];

pw.Widget _buildHeader(pw.Context context){ 
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children:[
      pw.Text(
        'myCustomer',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 18,
          letterSpacing: -0.02,
          color: PdfColors.black
        )
        ),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children:[
            pw.Text(
              'Jinet',
              style: pw.TextStyle(
                fontSize: 18,
                color: PdfColors.black
                )
            ),
            pw.Text(
              '078909879',
              style: pw.TextStyle(
                fontSize: 14,
                color: PdfColors.grey800
              )

            ),
          ] ),

          pw.SizedBox(height: 20)

  ]);

}

pw.Widget _buildFooter(pw.Context context){
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children:[
      pw.Container(
        height:40.0,
        width: 40.0,
        color: PdfColors.black
        ),
      pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
         style: const pw.TextStyle(
          fontSize: 12,
          color: PdfColors.grey

         )
      ),
      
    ] );
}

pw.Widget _buildContentHeader(pw.Context context){
  return pw.Text(
    'Transaction Report (0000)',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 16,
      color:PdfColors.black
    )
  );

}

pw.Widget _buildContent(pw.Context context){
  return pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.start,
    children:[
      pw.Column(
        children:[
          pw.Text(
            'Report Generated at : {0} {0}'
          ),
          pw.Text(
            'Transaction Id :'
          ),
          pw.Text(
            'Number of Customer : 1'
          ),
          pw.Text(
            'Total Received : '
          ),
          pw.Text(
            'Total Gave : '
          )
        ] )
    ] );
}

pw.Widget _contentTableHeader(pw.Context context){
  return pw.Text(
     'Customer : ',
     style: pw.TextStyle(
       fontWeight: pw.FontWeight.bold,
       fontSize: 16,
       color:PdfColors.black
     )
  );
}

pw.Widget _contentTable(pw.Context context){
  const tableHeaders=[
    'S.NO',
    'Date',
    'Name',
    'Note',
    'Received',
    'Gave'
  ];

  return pw.Table.fromTextArray(
    border: null,
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration:pw.BoxDecoration(
      borderRadius: 2,
      color:PdfColors.grey
    ),
    headerHeight: 28,
    cellHeight: 35,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.centerRight,
      3: pw.Alignment.center,
      4: pw.Alignment.centerRight,
    },
    headerStyle: pw.TextStyle(
      color:PdfColor.fromInt(0xff333CC1),
      fontSize: 13,

    ),
    headers: List<String>.generate(
      tableHeaders.length, (col) => tableHeaders[col]),
    //TODO find a suitable of generating the transactions from the list of transactions.
    data: List<List<String>>.generate(
      tableHeaders.length, 
      (row)=>List<String>.generate(
        tableHeaders.length, (col) => null)
    )
    );


}

pw.Widget _contentTableFooter(pw.Context context){
  const tableFooters=[
    'Total',
    'Balance',
  ];


   return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(
        // borderRadius: 2,
        color: PdfColor.fromInt(0xFF333CC1),
      ),
      headerHeight: 30,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        //color: PdfColor.fromInt(0xFF333CC1),
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: 1,
        ),
      ),
      headers: List.generate(
        tableFooters.length,
        (footerTitle) => tableFooters[footerTitle],
      ),
      data: List.generate(
        footerBody.length,
        (row) => List.generate(
          tableFooters.length,
          (footerItems) =>
              footerBody[row].getIndex(footerItems), // getting the items
        ),
      ),
    );
}




Future<void> generateReport(BuildContext context) async {
    final Directory appDocDir = await getExternalStorageDirectory();
    final String appDocPath = appDocDir.path;
    final String path = '$appDocPath/report' +'.pdf';
    File file = File(path);
    print('Save as file ${file.path} ...');
    //file.writeAsBytesSync(pdf.save());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path:path),
      ),
    );
  }


}
String _formatCurrency(double amount) {
  return '\N${amount.toStringAsFixed(2)}';
}
//TODO get the balance from the transaction class
class FooterData {
  const FooterData(this.creditBal, this.debitBal);

  final double creditBal;
  final double debitBal;

  double get total => creditBal - debitBal;

  getIndex(int index) {
    switch (index) {
      case 0:
        return _formatCurrency(creditBal);
      case 1:
        return _formatCurrency(debitBal);
      case 2:
        return _formatCurrency(total);
    }
  }
}



  


