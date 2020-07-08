import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class TransactionService with ReactiveServiceMixin {
  static const String _boxname = "transactionBox";

  RxValue<List<TransactionModel>> _transactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get transactions => _transactions.value;
  List<String> formattedate = [];
  String date;

  TransactionModel _transaction;

  TransactionService(){
    listenToReactiveValues([_transactions]);
  }

  void getTransactions() async{
    var box = await Hive.openBox<TransactionModel>(_boxname);
    _transactions.value = box.values.toList();
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(dformat.format(DateTime.parse(transactions[i].date)).toString() != date) {
        date = dformat.format(DateTime.parse(transactions[i].date)).toString();
        formattedate.add(date);
      }
    }
    print('done');
  }

  void addTransaction(TransactionModel transaction) async {
    var box = await Hive.openBox<TransactionModel>(_boxname);
    await box.add(transaction);
    _transactions.value = box.values.toList();
    formattedate = [];
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(dformat.format(DateTime.parse(transactions[i].date)).toString() != date) {
        date = dformat.format(DateTime.parse(transactions[i].date)).toString();
        formattedate.add(date);
      }
    }
    print('done');
  }

}