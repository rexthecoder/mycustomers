import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'repository.dart';

@lazySingleton
class TransactionService with ReactiveServiceMixin {
  static const String _boxname = "transactionBox";

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

  RxValue<List<TransactionModel>> _owingcustomers = RxValue<List<TransactionModel>>(initial: []);
  List get owingcustomers => _owingcustomers.value;

  RxValue<List<TransactionModel>> _owedcustomers = RxValue<List<TransactionModel>>(initial: []);
  List get owedcustomers => _owedcustomers.value;

  List<String> formattedate = [];
  String date;
  var box = Hive.openBox<TransactionModel>(_boxname);

  RxValue<TransactionModel> _stransaction = RxValue<TransactionModel>(initial: null);
  TransactionModel get stransaction => _stransaction.value;


  TransactionService(){
    listenToReactiveValues([_transactions, _debitlist, _creditlist, _alltransactions]);
  }

  void setTransaction(TransactionModel transaction){
    _stransaction.value = transaction;
  }

  void getAllTransactions() async{
    final bbox = await box;
    _alltransactions.value = bbox.values.toList();
    _alltransactions.value = new List<TransactionModel>.from(_alltransactions.value.reversed);
    _whatyouowe.value = 0;
    _owingcustomers.value = [];
    _owedcustomers.value = [];
    for(var item in _alltransactions.value){
      if(item.amount-item.paid > 0) {
        _owingcustomers.value.add(item);
      }
      if(item.paid-item.amount > 0) {
        _owedcustomers.value.add(item);
        _whatyouowe.value += item.paid-item.amount;
      }
    }
  }
  
  void getTransactions(int id) async{
    print('get'+id.toString());
    final bbox = await box;
    _transactions.value = [];
    for (var transaction in bbox.values.toList()) {
      if (transaction.cId == id){
        _transactions.value.add(transaction);
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
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == id){
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
  }

  void addTransaction(TransactionModel transaction) async {
    print(transaction.cId);
    final bbox = await box;
    await bbox.add(transaction);
    _transactions.value = [];
    for (var transactionb in bbox.values.toList()) {
      if (transactionb.cId == transaction.cId){
        _transactions.value.add(transactionb);
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
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == transaction.cId){
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
    }
    getAllTransactions();
    print('done');
  }

  void updateTransaction(TransactionModel transaction)async{
    final bbox = await box;
    await bbox.putAt(bbox.values.toList().indexOf(_stransaction.value), transaction);
    _transactions.value = [];
    for (var ttransaction in bbox.values.toList()) {
      if (ttransaction.cId == transaction.cId){
        _transactions.value.add(ttransaction);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == transaction.cId){
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
    getAllTransactions();
  }

}