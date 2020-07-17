import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDebtCreditViewModel extends ReactiveViewModel {
  final _debouncer = Debouncer(milliseconds: 100);
  final dformat = new DateFormat('dd/MM/yyyy');
  bool show = false;
  bool save = false;
  DateTime selectedDate = DateTime.now();
  DateTime dueDate;
  DateTime otherDate;
  String newDate;
  String newODate;
  bool date1err = false;
  bool date2err = false;
  List<String> items = [];
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  NavigationService _navigationService = locator<NavigationService>();
  final _customerContactService = locator<CustomerContactService>();
  CustomerContact get contact => _customerContactService.contact;
  final _bussinessService = locator<BussinessSettingService>();
  CountryCurrency get currency => _bussinessService.curren;
  final _logService = locator<LogsLocalDataSourceImpl>();

  double _amount;
  double get amount => _amount;

  String _error;
  String get error => _error;

  String _item;
  String get item => _item;

  bool isNumeric(String amt) {
    if (amt == null) {
      return false;
    }
    return num.tryParse(amt) != null;
  }

  void updateAmount(String value, bool update, String action) {
    _debouncer.run(() {
      if (value.length != 0) {
        String val = '';
        for (int i = 0; i < value.length; i++) {
          if (value[i] != ',') {
            val = val.toString() + value[i].toString();
          }
        }
        if (isNumeric(val)) {
          _error = null;
          _amount = double.parse(val);
          show = true;
          update
              ? amount != null && newODate != null ? save = true : save = false
              : action == 'debit'
                  ? amount != null && newDate != null && newODate.length > 0
                      ? save = true
                      : save = false
                  : amount != null && newODate != null
                      ? save = true
                      : save = false;
          notifyListeners();
        } else {
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
    date1err = false;
    amount != null && newDate.length > 0 && newODate.length != null
        ? save = true
        : save = false;
    notifyListeners();
  }

  void setOtherDate(DateTime date, bool update, String action) {
    otherDate = date;
    newODate = dformat.format(date);
    date2err = false;
    update
        ? amount != null && newODate != null ? save = true : save = false
        : action == 'debit'
            ? amount != null && newDate != null && newODate.length != null
                ? save = true
                : save = false
            : amount != null && newODate.length != null
                ? save = true
                : save = false;
    notifyListeners();
  }

  void updateItem(String value) {
    _item = value;
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void addItem(String action, bool update) {
    if (item != null) {
      if (item.length > 0) {
        items.insert(0, item);
        _item = null;
        !update && action == 'credit'
            ? amount != null && newODate.length != null
                ? save = true
                : save = false
            : amount != null &&
                    newDate.length != null &&
                    newODate.length != null
                ? save = true
                : save = false;
        notifyListeners();
      }
    }
  }

  void addtransaction(String action, bool update) {
    if (save) {
      date1err = false;
      date2err = false;
      if (update) {
        if (action == 'credit') {
          print(dueDate);
          print('crediting');
          TransactionModel transaction = new TransactionModel(
              cId: _transactionService.stransaction.cId,
              amount: _transactionService.stransaction.amount,
              paid: amount,
              goods: _transactionService.stransaction.goods,
              duedate: _transactionService.stransaction.duedate,
              boughtdate: _transactionService.stransaction.boughtdate,
              paiddate: otherDate.toString());
          _transactionService.updateTransaction(transaction);
          _logService.getValues(amount.toInt(), DateTime.now(), 'credit', contact.name, update);
          notifyListeners();
        } else {
          print('debiting');
          TransactionModel transaction = new TransactionModel(
              cId: _transactionService.stransaction.cId,
              amount: amount,
              paid: _transactionService.stransaction.paid,
              goods: _transactionService.stransaction.goods,
              duedate: _transactionService.stransaction.duedate,
              boughtdate: otherDate.toString(),
              paiddate: _transactionService.stransaction.paiddate);
          _transactionService.updateTransaction(transaction);
          _logService.getValues(amount.toInt(), DateTime.now(), 'debit', contact.name, update);
          notifyListeners();
        }
      } else {
        if (action == 'debit') {
          print(dueDate);
          TransactionModel transaction = new TransactionModel(
              cId: contact.id,
              amount: amount,
              paid: 0,
              goods: items,
              duedate: dueDate.toString(),
              boughtdate: otherDate.toString(),
              paiddate: null);
          _transactionService.addTransaction(transaction);
          _logService.getValues(amount.toInt(), DateTime.now(), 'debit', contact.name, update);
          notifyListeners();
        } else {
          TransactionModel transaction = new TransactionModel(
              cId: contact.id,
              amount: 0,
              paid: amount,
              goods: items,
              duedate: dueDate.toString(),
              boughtdate: null,
              paiddate: otherDate.toString());
          _transactionService.addTransaction(transaction);
          _logService.getValues(amount.toInt(), DateTime.now(), 'credit', contact.name, update);
          notifyListeners();
        }
      }
      _navigationService.replaceWith(Routes.mainTransaction);
    } else {
      if (newDate == null) {
        date1err = true;
      }
      if (newODate == null) {
        date2err = true;
      }
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService, _customerContactService, _bussinessService, _logService];
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
