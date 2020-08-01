import 'dart:async';
import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/phone_contact_service.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class AddDebtCreditViewModel extends ReactiveViewModel {
  final _debouncer = Debouncer(milliseconds: 100);
  final dformat = new DateFormat('dd/MM/yyyy');
  bool show = true;
  bool save = false;
  DateTime selectedDate = DateTime.now(); // = DateTime.now()
  DateTime dueDate;
  DateTime otherDate;
  String newDate;
  //String newODate; //
  String get newODate => dformat.format(DateTime.now());
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
  Store get currentStore => StoreRepository.currentStore;

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  final _phoneContactService = locator<PhoneContactService>();
  List<Customer> get contactsList => _phoneContactService.contact;

  ScrollController controller = new ScrollController();

  double _amount;
  double get amount => _amount;

  String _error;
  String get errormsg => _error;

  String _description;
  String get description => _description;

  String _name;
  String get name => _name;

  List<Contact> contacts = [];
  bool contains = false;

  bool _busy = true;

  bool get isLoadBusy => _busy;

  String namehint;
  bool shownames = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Customer selectedCustomer;
  var uuid = Uuid();

  String _customerName;
  String _customerPhoneNumber;

  String _dropDownValue = '+234';
  PhoneNumber number;
  List<String> _countryCodes = ['+234', '+254', '+250', '+230'];

  String get customerName => _customerName;
  String get customerPhoneNumber => _customerPhoneNumber;

  List<String> get countryCode => _countryCodes;
  String get dropDownValue => _dropDownValue;

  var inputNumberController = TextEditingController();
  final descFocus = FocusNode();

  TransactionModel get stransaction => _transactionService.stransaction;

  bool manual = false;
  bool numberr = false;
  PermissionService _permission = new PermissionService();

  final DialogService _dialogService = locator<DialogService>();

  List<Customer> filtered = [];

  init({String query}) async {
    number = PhoneNumber(isoCode: isoCode);
    final bool isPermitted = await _permission.getContactsPermission();

    if(_phoneContactService.contactsCount() != (await iOwnerServices.getPhoneContacts(query: query)).toList().length){
      //final bool isPermitted = await _permission.getContactsPermission();
      if(isPermitted) {
        _dialogService.registerCustomDialogUi(buildLoaderDialog);
        _dialogService.showCustomDialog(
        title: 'Please hold on while we fetch your contacts...');
        _busy = true;
        notifyListeners();
        await _phoneContactService.deleteall();
        for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
          print('Iterate');
          await _phoneContactService.addCustomer(customer);
        }
        _phoneContactService.getContacts();
        _busy = false;
        _dialogService.completeDialog(DialogResponse());
        notifyListeners();
      }
    } else {
      _phoneContactService.getContacts();
    }
    
    //List<Customer> temp = [];
    if(isPermitted) {
      print('here');
      // _busy = true;
      // contactsList.clear();
      // notifyListeners();
      // for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
      //   print('Iterate');
        
      //   contactsList.add(customer);
      //   //contactsList = temp;
      //   //_contactStream.add(contactsList);
      // }
      // manual = contactsList.length == 0;
      // if (_busy) {
      //   _busy = false;
      //   notifyListeners();
      // }
    } else {
      manual = true;
    }
    notifyListeners();
  }

  void setUpdate() {
    amountController.text = stransaction.amount.toString();
    _amount = stransaction.amount;
    newDate = dformat.format(DateTime.parse(stransaction.duedate));
    descController.text = stransaction.description;
    _description = stransaction.description;
    save = true;
  }

  void getContacts() async {
    contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    print(contacts);
  }

  void updateName(String value, String action) {
    _debouncer.run(() {
      _name = value;
      _busy = true;
      shownames = true;
      if (value.length == 0) {
        _name = null;
        manual = false;
        inputNumberController.clear();
        number = null;
        //shownames = false;
      }
      if (contactsList.length != 0) {
        manual = false;
        number = null;
        inputNumberController.clear();
      }
      action == 'debit'
          ? amount != null &&
                  newDate != null &&
                  name.length != 0 //&& number != null
              ? save = true
              : save = false
          : amount != null &&
                  newODate != null &&
                  name.length != 0 //&& number != null
              ? save = true
              : save = false;
      //manual = contactsList.where((element) => element.displayName.toUpperCase().contains(value.toUpperCase())).toList().length == 0;
      notifyListeners();
      filter(name);
      //init(query: name);
    });
    
    print(manual);
    resetContact();
    notifyListeners();
  }

  void filter(String name) {
    if(name != null) {
      List<Customer> temp = [];
      temp.addAll(contactsList);
      temp.retainWhere((element) => element.displayName.toUpperCase().contains(name.toUpperCase()));
      filtered = temp;
    }
    notifyListeners();
  }

  void setShowName(){
    shownames = true;
    notifyListeners();
  }

  void resetContact() {
    if(selectedCustomer != null && selectedCustomer.displayName != _name) {
      shownames = true;
      selectedCustomer = null;
      if(controller.position.pixels < controller.position.pixels+100) {
        controller.animateTo(controller.position.maxScrollExtent, duration: new Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      }
    }
  }

  void setName(Customer cus, String action) {
    searchController.text = cus.displayName;
    _name = cus.displayName;
    selectedCustomer = cus;
    action == 'debit'
          ? amount != null &&
                  newDate != null &&
                  name.length != 0 //&& number != null
              ? save = true
              : save = false
          : amount != null &&
                  newODate != null &&
                  name.length != 0 //&& number != null
              ? save = true
              : save = false;
    shownames = false;
    notifyListeners();
  }

  bool isNumeric(String amt) {
    if (amt == null) {
      return false;
    }
    return num.tryParse(amt) != null;
  }

  void updateAmount(String value, bool update, String action, bool newCus) {
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
              : newCus
                  ? action == 'debit'
                      ? amount != null &&
                              newDate != null &&
                              name != null //&& number != null
                          ? save = true
                          : save = false
                      : amount != null &&
                              newODate != null &&
                              name != null //&& number != null
                          ? save = true
                          : save = false
                  : action == 'debit'
                      ? amount != null && newDate != null
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

  void setDate(DateTime date, String action, bool newCus) {
    print(date);
    dueDate = date;
    newDate = dformat.format(date);
    date1err = false;
    descFocus.requestFocus();
    newCus
        ? action == 'debit'
            ? amount != null &&
                    newDate != null &&
                    name != null //&& number != null
                ? save = true
                : save = false
            : amount != null &&
                    newODate != null &&
                    name != null //&& number != null
                ? save = true
                : save = false
        : action == 'debit'
            ? amount != null && newDate != null
                ? save = true
                : save = false
            : amount != null && newODate != null ? save = true : save = false;
    notifyListeners();
  }

  void setOtherDate(DateTime date, bool update, String action, bool newCus) {
    print(date);
    otherDate = date;
    //newODate = dformat.format(date);
    date2err = false;
    descFocus.requestFocus();
    update
        ? amount != null && newODate != null ? save = true : save = false
        : newCus
            ? action == 'debit'
                ? amount != null &&
                        newDate != null &&
                        name != null //&& number != null
                    ? save = true
                    : save = false
                : amount != null &&
                        newODate != null &&
                        name != null //&& number != null
                    ? save = true
                    : save = false
            : action == 'debit'
                ? amount != null && newDate != null
                    ? save = true
                    : save = false
                : amount != null && newODate != null
                    ? save = true
                    : save = false;
    notifyListeners();
  }

  void updateItem(String value) {
    _description = value;
    notifyListeners();
  }

  void updateNumber(String action) {
    action == 'debit'
        ? amount != null &&
                newDate != null &&
                name != null && number != null
            ? save = true
            : save = false
        : amount != null && newODate != null && name != null && number != null
            ? save = true
            : save = false;
    notifyListeners();
  }

  void updateContact(String phoneNumber) {
    _customerPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateCountryCode(String value) {
    _dropDownValue = value;
    notifyListeners();
  }

  void setManual() {
    manual = true;
    notifyListeners();
  }

  // void removeItem(int index) {
  //   items.removeAt(index);
  //   notifyListeners();
  // }

  // void addItem(String action, bool update) {
  //   if (item != null) {
  //     if (item.length > 0) {
  //       items.insert(0, item);
  //       _item = null;
  //       !update && action == 'credit'
  //           ? amount != null && newODate.length != null
  //               ? save = true
  //               : save = false
  //           : amount != null &&
  //                   newDate.length != null &&
  //                   newODate.length != null
  //               ? save = true
  //               : save = false;
  //       notifyListeners();
  //     }
  //   }
  // }

  void addtransaction(String action, bool update, bool newCus)async {
    if (save) {
      date1err = false;
      date2err = false;
      if (update) {
        if (action == 'credit') {
          print(dueDate);
          print('crediting');
          TransactionModel transaction = new TransactionModel(
              tId: _transactionService.stransaction.tId,
              sId: _transactionService.stransaction.sId,
              amount: _transactionService.stransaction.amount,
              paid: amount,
              description: _transactionService.stransaction.description,
              duedate: _transactionService.stransaction.duedate,
              boughtdate: _transactionService.stransaction.boughtdate,
              paiddate: otherDate.toString());
          //_customerContactService.addContact(selectedCustomer.phone.isNotEmpty ? selectedCustomer.phone : 'No number', selectedCustomer.displayName, '', selectedCustomer.initials, action, transaction);
          await _transactionService.updateTransaction(transaction, contact).then((value) => _customerContactService.setContact(value));
          _customerContactService.getContacts(StoreRepository.currentStore.id);
          _logService.getValues(amount.toInt(), DateTime.now(), 'credit', contact.name, update);
          _navigationService.back();
          //_navigationService.replaceWith(Routes.mainTransaction);
          notifyListeners();
        } else {
          print('debiting');
          TransactionModel transaction = new TransactionModel(
              tId: _transactionService.stransaction.tId,
              sId: _transactionService.stransaction.sId,
              amount: amount,
              paid: _transactionService.stransaction.paid,
              description: _transactionService.stransaction.description,
              duedate: _transactionService.stransaction.duedate,
              boughtdate: otherDate.toString(),
              paiddate: _transactionService.stransaction.paiddate);
          //_customerContactService.addContact(selectedCustomer.phone.isNotEmpty ? selectedCustomer.phone : 'No number', selectedCustomer.displayName, '', selectedCustomer.initials, action, transaction);
          await _transactionService.updateTransaction(transaction, contact).then((value) => _customerContactService.setContact(value));
          _customerContactService.getContacts(StoreRepository.currentStore.id);
          _logService.getValues(
              amount.toInt(), DateTime.now(), 'debit', contact.name, update);
          //_navigationService.replaceWith(Routes.mainTransaction);
          _navigationService.back();
          notifyListeners();
        }
      } else {
        if (action == 'debit') {
          print(dueDate);
          TransactionModel transaction = new TransactionModel(
              tId: uuid.v4(),
              sId: currentStore.id,
              amount: amount,
              paid: 0,
              description: description,
              duedate: dueDate.toString(),
              boughtdate: DateTime.now().toString(),//otherDate.toString()
              paiddate: null);
          if (newCus) {
            numberr = false;
            number != null && number.phoneNumber != null
                ? number.phoneNumber.length == number.dialCode.length ? numberr = true : _customerContactService.addContact(
                    number.toString(),
                    name,
                    '',
                    name.split(' ').length > 1
                        ? (name.split(' ')[0][0] + name.split(' ')[1][0])
                            .toUpperCase()
                        : name.split(' ')[0][0].toUpperCase(),
                    action,
                    transaction,
                    currentStore.id)
                : _customerContactService.addContact(
                    selectedCustomer.phone.isNotEmpty
                        ? selectedCustomer.phone
                        : 'No number',
                    selectedCustomer.displayName,
                    '',
                    selectedCustomer.initials,
                    action,
                    transaction,
                    currentStore.id);
            _logService.getValues(amount.toInt(), DateTime.now(), 'debit', name, update);
          }
          if (!newCus) {
            print('here');
            await _transactionService.addTransaction(transaction, contact).then((value) => _customerContactService.setContact(value));
            _customerContactService.getContacts(StoreRepository.currentStore.id);
            //_navigationService.replaceWith(Routes.mainTransaction);
            _navigationService.back();
            _logService.getValues(amount.toInt(), DateTime.now(), 'debit', contact.name, update);
          }
          //_navigationService.replaceWith(Routes.mainTransaction);
          notifyListeners();
        } else {
          print('rrrr');
          TransactionModel transaction = new TransactionModel(
              tId: uuid.v4(),
              sId: currentStore.id,
              amount: 0,
              paid: amount,
              description: description,
              duedate: dueDate.toString(),
              boughtdate: null,
              paiddate: otherDate.toString());
          if (newCus) {
            numberr = false;
            number != null && number.phoneNumber != null
                ? number.phoneNumber.length == number.dialCode.length ? numberr = true : _customerContactService.addContact(
                    number.toString(),
                    name,
                    '',
                    name.split(' ').length > 1
                        ? (name.split(' ')[0][0] + name.split(' ')[1][0])
                            .toUpperCase()
                        : name.split(' ')[0][0].toUpperCase(),
                    action,
                    transaction,
                    currentStore.id)
                : _customerContactService.addContact(
                    selectedCustomer.phone.isNotEmpty
                        ? selectedCustomer.phone
                        : 'No number',
                    selectedCustomer.displayName,
                    '',
                    selectedCustomer.initials,
                    action,
                    transaction,
                    currentStore.id);
            _logService.getValues(amount.toInt(), DateTime.now(), 'credit', name, update);
          }
          if (!newCus) {
            print('here');
            await _transactionService.addTransaction(transaction, contact).then((value) => _customerContactService.setContact(value));
            _customerContactService.getContacts(StoreRepository.currentStore.id);
            //_navigationService.replaceWith(Routes.mainTransaction);
            _navigationService.back();
            _logService.getValues(amount.toInt(), DateTime.now(), 'credit', contact.name, update);
          }
          //_navigationService.replaceWith(Routes.mainTransaction);
          notifyListeners();
        }
      }
      //_navigationService.replaceWith(Routes.mainTransaction);
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
  List<ReactiveServiceMixin> get reactiveServices => [
        _transactionService,
        _customerContactService,
        _bussinessService,
        _logService,
        _phoneContactService
      ];
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
