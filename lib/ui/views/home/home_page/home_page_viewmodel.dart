import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/transaction_extension.dart';



class HomePageViewModel extends ReactiveViewModel {
  String _title = 'Home View';
  String get title => _title;

  int amountOwing= 500;

  final double _amount = 100.86;
  double get amount => _amount;

  void btnViewDetails() {
    print('hello');
  }

  final NavigationService _navigationService = locator<NavigationService>();
  final _customerContactService = locator<CustomerContactDataSource>();
  final _transactionService = locator<TransactionLocalDataSource>();
  

  PermissionService _permission =  locator<IPermissionService>();
  
  List<CustomerContact> get contacts => _customerContactService.contacts;
  List<TransactionModel> get transactions => _transactionService.alltransactions;
  double get whatyouowe  => _transactionService.whatyouowe;
  int tabNo = 0;
  List<CustomerContact> get owingcustomers => _transactionService.owingcustomers;
  List<CustomerContact> get owedcustomers => _transactionService.owedcustomers;
  double get totaldebt => _customerContactService.totaldebt;
  double get totalcredit => _customerContactService.totalcredit;
  final _bussinessService = locator<BussinessSettingService>();
  CountryCurrency get currency => _bussinessService.curren;
  CountryCurrency get oldcurrency => _bussinessService.oldcurren;
  String sName;
  String sDName;
  String sCName;
  bool contains;
  bool containsD;
  bool containsC;
  Store get currentStore => StoreRepository.currentStore;

  // Future navigateToAddCustomer() async {
  //   final bool isPermitted =
  //       await _permission.getContactsPermission();
  //   if (isPermitted) _navigationService.navigateTo(Routes.importCustomerViewRoute);
  //   else _navigationService.navigateTo(Routes.addCustomerManually);
  // }

  double getamount(double amt){
    return amt;
    // if(oldcurrency != null) {
    //   if(oldcurrency.symbol == '₦') {
    //     if(currency.symbol == '₦'){
    //       return amt;
    //     }else if(currency.symbol == '\$'){
    //       return amt * 385.505;
    //     }else{
    //       return amt * 0.192873;
    //     }
    //     //(currency.symbol == '₹')
    //   }else if(oldcurrency.symbol == '\$') {
    //     if(currency.symbol == '₦'){
    //       return amt / 385.505;
    //     }else if(currency.symbol == '\$'){
    //       return amt;
    //     }else{
    //       return amt * 74.7272456;
    //     }
    //   } else if(oldcurrency.symbol == '₹') {
    //     if(currency.symbol == '₦'){
    //       return amt / 0.192873;
    //     }else if(currency.symbol == '\$'){
    //       return amt / 74.7272456;
    //     }else{
    //       return amt;
    //     }
    //   }
    // } else {
    //   return amt;
    // }
  }

  void getTransactions() {
    print('here');
    _transactionService.getAllTransactions(currentStore?.id ?? 'ghjkl3-.dj');
    notifyListeners();
  }

  bool checkToday(String date) {
    final dformat = new DateFormat('dd/MM/yyyy');
    return dformat.format(DateTime.parse(date)) == dformat.format(DateTime.now());
  }

  void searchName(String value){
    sName = value;
    contains = false;
    for(var item in contacts){
      if(item.name.toLowerCase().contains(sName.toLowerCase())){
        contains = true;
      }
    }
    notifyListeners();
  }

  void searchDName(String value){
    sDName = value;
    containsD = false;
    for(var cus in owingcustomers){
      //for(var item in contacts){
        //if(item.transactions.contains(cus)){
          if(cus.name.toLowerCase().contains(sDName.toLowerCase())){
            containsD = true;
          }
        //}
      //}
    }
    notifyListeners();
  }

  void searchCName(String value){
    sCName = value;
    containsC = false;
    for(var cus in owedcustomers){
      //for(var item in contacts){
        //if(item.transactions.contains(cus)){
          if(cus.name.toLowerCase().contains(sCName.toLowerCase())){
            containsC = true;
          }
        //}
      //}
    }
    notifyListeners();
  }

  double tdebt() {
    double sum = 0;
    for(var cus in contacts) {
      double tempd = 0;
      double tempc = 0;
      for(var trans in cus.transactions.helperToList()) {
        tempd += trans.amount;
        tempc += trans.paid;
      }
      sum += tempd - tempc > 0 ? tempd - tempc : 0;
    }
    return sum.abs();
  }

  double tcredit() {
    double sum = 0;
    for(var cus in contacts) {
      double tempd = 0;
      double tempc = 0;
      for(var trans in cus.transactions.helperToList()) {
        tempd += trans.amount;
        tempc += trans.paid;
      }
      sum += tempc - tempd > 0 ? tempc - tempd : 0;
    }
    return sum.abs();
  }

  double getdebt(CustomerContact cus) {
    double tempd = 0;
    double tempc = 0;
    for(var trans in cus.transactions.helperToList()) {
      tempd += trans.amount;
      tempc += trans.paid;
    }
    return tempd - tempc;
  }

  double getcredit(CustomerContact cus) {
    double tempd = 0;
    double tempc = 0;
    for(var trans in cus.transactions.helperToList()) {
      tempd += trans.amount;
      tempc += trans.paid;
    }
    return tempc - tempd;
  }

  double bought(){
    double sum = 0;
    for (var item in transactions) {
      if(item.amount > item.paid) {
        sum += item.amount;
      }
    }
    return sum;
  }

  String getdebtduedate(CustomerContact cus) {
    return cus.transactions.helperToList().where((element) => element.amount != 0).toList().last.duedate;
  }

  String getcreditduedate(CustomerContact cus) {
    return cus.transactions.helperToList().where((element) => element.paid != 0).toList().last.duedate;
  }

  double paid(){
    double sum = 0;
    for (var item in transactions) {
      if(item.paid != 0) {
        sum += item.paid;
      }
    }
    return sum;
  }

  void changeTab(int val){
    tabNo = val;
    notifyListeners();
  }

  void getContacts() {
    _customerContactService.getContacts(StoreRepository.currentStore.id);
  }

  void setContact(CustomerContact cus) {
    //print(id);
    //CustomerContact cus = new CustomerContact(id: id, name: name, phoneNumber: phone, initials: initials);
    _customerContactService.setContact(cus);
    _navigationService.navigateTo(Routes.mainTransaction);
  }

  TextEditingController debtorsController = TextEditingController();
  void searchDebtors(value){
    notifyListeners();
    //todo: implement debtors search
  }
  TextEditingController creditorsController = TextEditingController();
  void searchCreditors(value){
    notifyListeners();
    //todo: implement creditors search
  }
  TextEditingController allCustomersController = TextEditingController();
  void searchAllCustomers(value){
    notifyListeners();
    //todo: implement allCustomers search
  }

  void navigateToDebt(){
    _navigationService.navigateTo(Routes.addnewDebt);
  }

  void navigateToCredit(){
    _navigationService.navigateTo(Routes.addnewCredit);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_customerContactService, _transactionService, _bussinessService];
}

