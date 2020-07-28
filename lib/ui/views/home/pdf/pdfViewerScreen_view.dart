import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:mycustomers/core/pdf/storagepermission.dart';


import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';





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
  final document = pw.Document();
  // MainTransactionViewModel model;

  GeneralTransactionReport();

buildPdf(BuildContext context)async {
    await storagePermission();

  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      header: _buildHeader,
      footer: _buildFooter,
      build:(context)=>[
        _buildContentHeader(context),
        pw.SizedBox(height: 25),
        _buildContent(context),
        pw.SizedBox(height: 20),
        _contentTableHeader(context),
        _contentTable(context),
        _contentTableFooter(context)

      ]
      )
  );

 await generateReport(context);

}

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
    file.writeAsBytesSync(document.save());

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



  


