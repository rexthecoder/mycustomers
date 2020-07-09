import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/transaction/transaction_service.dart';
import 'package:stacked/stacked.dart';

class AddDebtCreditViewModel extends ReactiveViewModel{
  final _debouncer = Debouncer(milliseconds: 800);
  final dformat = new DateFormat('dd/MM/yyyy');
  bool show = false;
  bool save = false;
  DateTime selectedDate = DateTime.now();
  DateTime dueDate;
  String newDate;
  List<String> items = [];
  final _transactionService = locator<TransactionService>();

  final _customerContactService = locator<CustomerContactService>();
  CustomerContact get contact => _customerContactService.contact;

  double _amount;
  double get amount => _amount;

  String _error;
  String get error => _error;

  String _item;
  String get item => _item;

  bool isNumeric(String amt) {
    if(amt == null) {
      return false;
    }
    return num.tryParse(amt) != null;
  }

  void updateAmount(String value) {
    _debouncer.run(() {
      if(value.length != 0) {
        String val = '';
        for (int i = 0; i < value.length; i++) {
          if(value[i] != ','){
            val = val.toString()+value[i].toString();
          }
        }
        if (isNumeric(val)){
          _error = null;
          _amount = double.parse(val);
          show = true;
          amount != null && newDate != null && items.length > 0 ? save = true : save = false;
          notifyListeners();
        } else{
          _error = 'Enter a valid amount';
          notifyListeners();
        }
      } else {
        _amount = null;
        save = false;
        notifyListeners();
      }
    });
  }

  void setDate(DateTime date) {
    dueDate = date;
    newDate = dformat.format(date);
    amount != null && newDate.length > 0 && items.length > 0 ? save = true : save = false;
    notifyListeners();
  }

  void updateItem(String value){
    _item = value;
    notifyListeners();
  }
  
  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void addItem() {
    if(item != null) {
      if(item.length > 0) {
        items.insert(0, item);
        _item = null;
        amount != null && newDate.length > 0 && items.length > 0 ? save = true : save = false;
        notifyListeners();
      }
    }
  }

  void addtransaction(String action) {
    if(action == 'debit'){
      print(dueDate);
      TransactionModel transaction = new TransactionModel(cId: contact.id, amount: amount, paid: 0, goods: items, date: dueDate.toString());
      _transactionService.addTransaction(transaction);
      notifyListeners();
    } else {
      TransactionModel transaction = new TransactionModel(cId: contact.id, amount: 0, paid: amount, goods: items, date: dueDate.toString());
      _transactionService.addTransaction(transaction);
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService, _customerContactService];
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({ this.milliseconds });

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}