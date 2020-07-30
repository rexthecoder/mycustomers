import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/ui/views/home/pdf/pdfViewerScreen_view.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import '../../extensions/transaction_extension.dart';

abstract class TransactionLocalDataSource{
  //Future<void> init();

  void setTransaction(TransactionModel transaction);

  void getAllTransactions(String id);

  Future<void> getTransactions(CustomerContact cus);

  Future<CustomerContact> addTransaction(TransactionModel transaction, CustomerContact cus);

  Future<CustomerContact> updateTransaction(TransactionModel transaction, CustomerContact cus);

  Future<CustomerContact> deleteTransaction(CustomerContact cus);
}


@lazySingleton
class TransactionLocalDataSourceImpl extends TransactionLocalDataSource with ReactiveServiceMixin {
  //static const String _boxname = "transactionBox";
  final _hiveService = locator<HiveInterface>();

  //bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.transaction);
  //Box<TransactionModel> get _transactionBox => _hiveService.box<TransactionModel>(HiveBox.transaction);

  Box<CustomerContact> get _contactBox => _hiveService.box<CustomerContact>(HiveBox.contact);

  RxValue<List<TransactionModel>> _alltransactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get alltransactions => _alltransactions.value;

  RxValue<double> _whatyouowe = RxValue<double>(initial: 0);
  double get whatyouowe => _whatyouowe.value;

  RxValue<List<TransactionModel>> _transactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get transactions => _transactions.value;

  RxValue<List<TransactionModel>> _debitlist = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get debitlist => _debitlist.value;

  RxValue<List<TransactionModel>> _creditlist = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get creditlist => _creditlist.value;

  RxValue<List<CustomerContact>> _owingcustomers = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get owingcustomers => _owingcustomers.value;

  RxValue<List<CustomerContact>> _owedcustomers = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get owedcustomers => _owedcustomers.value;

  RxValue<List<TransactionModel>> _report = RxValue<List<TransactionModel>>(initial: []);
  List get report => _report.value;

  RxValue<double> _reportdebt = RxValue<double>(initial: 0);
  double get reportdebt => _reportdebt.value;
  
  RxValue<double> _reportcredit = RxValue<double>(initial: 0);
  double get reportcredit => _reportcredit.value;

  List<String> formattedate = [];
  String date;
  
  get box => _hiveService.openBox<TransactionModel>(HiveBox.transaction);
//   var box = Hive.openBox<TransactionModel>(_boxname);

  RxValue<TransactionModel> _stransaction = RxValue<TransactionModel>(initial: null);
  TransactionModel get stransaction => _stransaction.value;

  final dformat = new DateFormat('dd/MM/yyyy');


  TransactionLocalDataSourceImpl(){
    listenToReactiveValues([_transactions, _debitlist, _creditlist, _alltransactions, _report, _reportdebt, _reportcredit]);
  }

  // @override
  // Future<void> init() async {
  //   _hiveService.registerAdapter(TransactionAdapter());

  //   if (!_isBoxOpen) {
  //     await box;
  //   }
  // }

  @override
  void setTransaction(TransactionModel transaction){
    _stransaction.value = transaction;
  }

  void setReport(DateTime start, DateTime stop, CustomerContact cus, BuildContext context, String symbol)async {
    print(start);
    print(stop);
    final dformat = new DateFormat('dd/MM/yyyy');
    _report.value = [];
    for(var item in _transactions.value) {
      print('checking...');
      if(item.boughtdate != null) {
        print('bought');
        print(DateTime.parse(item.boughtdate).difference(start).inDays);
          print(DateTime.parse(item.boughtdate).difference(stop).inDays);
          print(item.boughtdate);
        if((DateTime.parse(item.boughtdate).difference(start).inDays <= 0)
        && 
        (DateTime.parse(item.boughtdate).difference(stop).inDays >= 0)) {
          print(DateTime.parse(item.boughtdate).difference(start).inDays);
          print(DateTime.parse(item.boughtdate).difference(stop).inDays);
          print(item.boughtdate);
          _report.value.add(item);
        }
      }
      if(item.paiddate != null) {
        print('credit');
        print(DateTime.parse(item.paiddate).difference(start).inDays);
          print(DateTime.parse(item.paiddate).difference(stop).inDays);
          print(item.paiddate);
        if((DateTime.parse(item.paiddate).difference(start).inDays <= 0) 
        && 
        (DateTime.parse(item.paiddate).difference(stop).inDays >= 0)) {
          print(DateTime.parse(item.paiddate).difference(start).inDays);
          print(DateTime.parse(item.paiddate).difference(stop).inDays);
          print(item.paiddate);
          _report.value.add(item);
        }
      }
    }
    _reportdebt.value = 0;
    _reportcredit.value = 0;
    for(var item in _report.value) {
      _reportdebt.value += item.amount;
      _reportcredit.value += item.paid;
    }
    //GeneralTransactionReport().buildPdf(context);
    GeneralTransactionReport().buildpdf( context,
      transactions: _report.value,
      start: dformat.format(start),
      stop: dformat.format(stop),
      customer: cus,
      totaldebt: _reportdebt.value,
      totalcredit: _reportcredit.value,
      symbol: symbol
    ).then((value) async{
      await GeneralTransactionReport().savepdf(context, value);
    });
    //await GeneralTransactionReport().savepdf(context);
  }

  void getAllTransactions(String id) async{
    print(id);
    //final bbox = await box;
    _alltransactions.value = [];
    print(_contactBox.values.toList());
    for(var cont in _contactBox.values.toList()) {
      if (cont.storeid == id){
        //print(cont.transactions);
        _alltransactions.value = [..._alltransactions.value, ...cont.transactions.helperToList()];
      }
    }
    print(_alltransactions.value);
    //_alltransactions.value = new List<TransactionModel>.from(_alltransactions.value.reversed);
    _whatyouowe.value = 0;
    _owingcustomers.value = [];
    _owedcustomers.value = [];
    for(var cus in _contactBox.values.toList()) {
      if(cus.storeid == id) {
        double tempd = 0;
        double tempc = 0;
        for(var item in cus.transactions.helperToList()){
          tempd += item.amount;
          tempc += item.paid;
        }
        print(tempd);
        print(tempc);
        print(tempd - tempc);
        if(tempd - tempc > 0) {
          _owingcustomers.value.add(cus);
        }
        if(tempc - tempd > 0) {
          _owedcustomers.value.add(cus);
          //_whatyouowe.value += item.paid-item.amount;
        }
      }
    }
  }

  @override  
  Future<void> getTransactions(CustomerContact cus) async{
    //print('get'+id.toString());
    //final bbox = await box;
    _transactions.value = cus.transactions.helperToList();
    // for (var transaction in _contactBox.values.toList()) {
    //   if (transaction.cId == id && transaction.sId == stid){
    //     _transactions.value.add(transaction);
    //     print(transaction.boughtdate);
    //   }
    // }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].boughtdate != null){
        for(int k = 0; k<formattedate.length; k++){
          if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
            //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
            //formattedate.add(date);
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
        }
        isInDate = false;
      }

      if(transactions[i].paiddate != null){
        for(int j=0; j<formattedate.length; j++){
          if(formattedate[j].toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
        }
        isInDate = false;
      }
    }
  }
  

  @override
  Future<CustomerContact> addTransaction(TransactionModel transaction, CustomerContact cus) async {
    //print(transaction.cId);
    //final bbox = await box;
    //await _transactionBox.add(transaction);
    CustomerContact temp = cus;
    temp.transactions.putIfAbsent(transaction.tId, () => transaction);
    await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);
    _transactions.value = temp.transactions.helperToList();
    // for (var transactionb in _transactionBox.values.toList()) {
    //   if (transactionb.cId == transaction.cId){
    //     _transactions.value.add(transactionb);
    //   }
    // }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].boughtdate != null){
        for(int k = 0; k<formattedate.length; k++){
          if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
            //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
            //formattedate.add(date);
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
        }
        isInDate = false;
      }

      if(transactions[i].paiddate != null){
        for(int j=0; j<formattedate.length; j++){
          if(dformat.format(DateTime.parse(transactions[j].boughtdate)).toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
        }
        isInDate = false;
      }
    }
    getAllTransactions(transaction.sId);
    print('done');
    return temp;
  }

  @override
  Future<CustomerContact> updateTransaction(TransactionModel transaction, CustomerContact cus)async{
    //final bbox = await box;
    CustomerContact temp = cus;
    temp.transactions.update(transaction.tId, (value) => transaction);
    await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);

    _transactions.value = temp.transactions.helperToList();
    // for (var ttransaction in _transactionBox.values.toList()) {
    //   if (ttransaction.cId == transaction.cId){
    //     _transactions.value.add(ttransaction);
    //   }
    // }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].boughtdate != null){
        for(int k = 0; k<formattedate.length; k++){
          if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
            //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
            //formattedate.add(date);
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
        }
        isInDate = false;
      }

      if(transactions[i].paiddate != null){
        for(int j=0; j<formattedate.length; j++){
          if(dformat.format(DateTime.parse(transactions[j].boughtdate)).toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
            isInDate = true;
          }
        }
        if(!isInDate){
          formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
        }
        isInDate = false;
      }
    }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    getAllTransactions(transaction.sId);
    return temp;
  }

  double getamount(double amt, CountryCurrency oldcurrency, CountryCurrency currency){
    if(oldcurrency != null) {
      if(oldcurrency.symbol == '₦') {
        if(currency.symbol == '₦'){
          return amt;
        }else if(currency.symbol == '\$'){
          return amt / 385.505;
        }else{
          return amt / 0.192873;
        }
        //(currency.symbol == '₹')
      }else if(oldcurrency.symbol == '\$') {
        if(currency.symbol == '₦'){
          return amt * 385.505;
        }else if(currency.symbol == '\$'){
          return amt;
        }else{
          return amt / 74.7272456;
        }
      } else if(oldcurrency.symbol == '₹') {
        if(currency.symbol == '₦'){
          return amt * 0.192873;
        }else if(currency.symbol == '\$'){
          return amt * 74.7272456;
        }else{
          return amt;
        }
      }
    }
    return amt;
  }

  void updateamount(CountryCurrency oldcurrency, CountryCurrency currency, String stid) async{
    for(var cus in _contactBox.values.toList()) {
      List<TransactionModel> hold = [];
      for(var item in cus.transactions.helperToList()) {
        print(oldcurrency.symbol);
        print(currency.symbol);
        print(getamount(item.amount, oldcurrency, currency));
        TransactionModel trns = new TransactionModel(
          tId: item.tId,
          sId: item.sId,
          amount: getamount(item.amount, oldcurrency, currency),
          paid: getamount(item.paid, oldcurrency, currency),
          duedate: item.duedate,
          boughtdate: item.boughtdate,
          paiddate: item.paiddate,
          description: item.description
        );
        hold.add(trns);
      }
      CustomerContact temp = new CustomerContact(
        name: cus.name,
        phoneNumber: cus.phoneNumber,
        id: cus.id,
        initials: cus.initials,
        storeid: cus.storeid,
        market: cus.market,
        transactions: hold.helperToMap(),
        messages: cus.messages
      );
      await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);
      getAllTransactions(stid);
    }
    getAllTransactions(stid);
  }

  @override
  Future<CustomerContact> deleteTransaction(CustomerContact cus)async {
    CustomerContact tempc = cus;
    tempc.transactions.remove(_stransaction.value.tId);
    await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), tempc);
    getAllTransactions(stransaction.sId);
    getTransactions(tempc);
    return tempc;
    //_stransaction.value = null;
  }

}
