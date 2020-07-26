import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/message_service.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';


class MarketingHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  // dummy data
  // TODO: implement service to get frequently contacted
  List _persons = [
    {'name': 'Seyi Onifade', 'number': '09088355273'},
    {'name': 'Mark Essien', 'number': '09088355273'},
    {'name': 'Ufe Atabo', 'number': '09088355273'}
  ];
  List<String> dummyQuickTextMessages = [
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend'
  ];

  // TODO: implement service to get notification status
  bool _notification = true;

  bool get notification => _notification;

  List get persons => _persons;

  // Function to serve as a helper for the navigation
  Future navigateToSendMessageView() async {
    await _navigationService.navigateTo(Routes.quickMessages, arguments: _selectedCustomers);
//    await _navigationService.navigateTo(Routes.sendMessageViewRoute, arguments: _selectedCustomers);
  }

  // Get the services required
  ICustomerService _customerService = locator<ICustomerService>();
  final _contactService = locator<CustomerContactService>();
  final _messageService = locator<MessageService>();

  

  List<Customer> allCustomers = [];

  List<CustomerContact> _selectedCustomers = [];
  List<CustomerContact> get selectedCustomers => _selectedCustomers;

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  List<CustomerContact> get scustomers => _contactService.getCustomermarket(StoreRepository.currentStore.id).where((element) => element.name.toUpperCase().contains(_searchTerm.toUpperCase()));

  List<CustomerContact> get customers => _contactService.getCustomermarket(StoreRepository.currentStore.id);
  Message getmsg(String id) => _messageService.getLast(id);

  //bool isFrequent(String id) => _messageService.isFrequent(id) > 2;

  void setcontact(CustomerContact cont){
    _contactService.setContact(cont);
  }

  List<CustomerContact> frequents() {
    List<Message> temp = [];
    List<CustomerContact> tempc = [];
    for (var item in customers) {
      for(var msg in _messageService.getAllMessages()) {
        if(item.id == msg.cId) {
          temp.add(msg);
          if(temp.length > 2) {
            tempc.add(item);
          }
        }
      }
    }
    return tempc;
  }

  List<Customer> _allSelectedCustomers = [];
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  List<Customer> get searchedCustomer => allCustomers.where(
        (Customer customer) =>
    customer.name.contains(searchPattern) ||
        customer.lastName.contains(searchPattern) ||
        customer.phone.contains(searchPattern)||
        customer.email.contains(searchPattern),
  ).toList();
  List<Customer> get allSelectedCustomers => _allSelectedCustomers.where(
        (Customer customer) =>
            customer.name.contains(searchPattern) ||
            customer.lastName.contains(searchPattern) ||
            customer.phone.contains(searchPattern) ||
            customer.email.contains(searchPattern),
      ).toList();


  /// Data checking section

  bool get hasData => customers.isNotEmpty;
  bool get hasSelected => _selectedCustomers.isNotEmpty;
  int get numberOfSelected => _selectedCustomers.length;
  bool isSelected(CustomerContact customer) => _selectedCustomers.contains(customer);
  bool get allSelected => customers.length == _selectedCustomers.length;

  TextEditingController searchController = TextEditingController();
  search(String keyword) {
    _searchTerm = keyword;
    notifyListeners();
  }

  void addCustomer(CustomerContact customer) {
    _selectedCustomers.add(customer);
    notifyListeners();
  }

  void deselectCustomer(CustomerContact customer) {
    _selectedCustomers.removeWhere((element) => element.id == customer.id);
    notifyListeners();
  }
  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
  }

  void selectAllCustomers() {
    _selectedCustomers.clear();
    _selectedCustomers.addAll(customers);
    notifyListeners();
  }

  void deselectAllCustomers() {
    _selectedCustomers = [];
    notifyListeners();
  }
  // void removeCustomers(Customer customer) {
  //   allCustomers.removeWhere((element) => element.phone == customer.phone);
  //   _selectedCustomers.removeWhere((element) => element.phone == customer.phone);
  //   notifyListeners();
  // }
//  void updateCustomers() async{
//    fianl customerList = await _navigationService
//  }

 PermissionService _permission =  locator<IPermissionService>();
  Future checkPermission() async {
    
     return await _permission.getContactsPermission(); 
  }
  Future requestPermission() async{
    return await [Permission.contacts].request();
  }
   Future navigateToAddCustomers(context) async{
    //  Navigator.of(context).pushNamed(Routes.addCustomerMarketing, arguments: _allFrequentCustomers).then((_){
    //    final arguments = ModalRoute.of(context).settings.arguments as Map;
    //    final result = arguments['result'];
    //  allCustomers = result != null ?[...allCustomers,...result]:allCustomers;
    //  _allFrequentCustomers = allCustomers;
    //   notifyListeners();
     
    //  });
    _navigationService.navigateTo(Routes.addCustomerMarketing);
    notifyListeners();
  }
  Future navigateToAddNewCustomer(context) async{
    Navigator.of(context).pushNamed(Routes.addNewCustomerMarketing).then((_){
       final arguments = ModalRoute.of(context).settings.arguments as Map;
       final result = arguments['result'];
     allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
      notifyListeners();
     
     });
    notifyListeners();
  }
  Future navigateToMessageHistory(CustomerContact cus) async{
    _contactService.setContact(cus);
    _navigationService.navigateTo(Routes.messageHistoryView);
  }

  Future navigateToSendMessage(context) async{
    // Navigator.of(context).pushNamed(Routes.sendMessageViewRoute,arguments: _selectedCustomers).then((_){
    //    final arguments = ModalRoute.of(context).settings.arguments as Map;
    //    final result = arguments['result'];
    //  allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
    //   notifyListeners();
     
    //  });
    // notifyListeners();
  }


  

  Future navigateToAddCustomer() async {
    var contactList;
    final bool isPermitted =
        await _permission.getContactsPermission();

    if(!isPermitted){
      await [Permission.contacts].request();
    }else if(isPermitted){
      contactList = await _navigationService
        .navigateTo(Routes.addCustomerMarketing);
    }else{
      contactList = await  _navigationService
        .navigateTo(Routes.addNewCustomerMarketing);
    }
    // if (isPermitted) contactList = await _navigationService
    //     .navigateTo(Routes.addCustomerMarketing);
    // else contactList = await  _navigationService
    //     .navigateTo(Routes.addNewCustomerMarketing);
    // await contactList;
//    print(contactList);
//    final results = contactList['result'];
//    allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;
//    allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;



//    if(_selectedCustomers.length !=0 ){
//      _navigationService
//          .navigateTo(Routes.sendMessageViewRoute, arguments: _selectedCustomers);
//    }else{
//      if (isPermitted) contactList = await _navigationService
//          .navigateTo(Routes.addCustomerMarketing);
//      else contactList = await  _navigationService
//          .navigateTo(Routes.addNewCustomerMarketing);
//      await contactList;
//      allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;
//    }
//    if (isPermitted) contactList= await _navigationService
//        .navigateTo(Routes.addCustomerMarketing);
//    else await [Permission.contacts].request();
//    allCustomers
//     = await contactList.length != 0?contactList:allCustomers;
//    await contactList;
//    if(!contactList==null){allCustomers =  contactList;}

    notifyListeners();
  }


  void sendMessage(){
    

    _navigationService
        .navigateTo(Routes.quickMessages,arguments: _selectedCustomers);
//        .navigateTo(Routes.sendMessageViewRoute,arguments: _selectedCustomers);
  }

  /// View initialize and close section

  popView() {
    _navigationService.back();
  }

  returnCustomers() {
    _navigationService.back(result: _selectedCustomers);
  }

  @override
  Future futureToRun() async {
   _allSelectedCustomers = await _customerService.getCustomers('1');
  }
}
