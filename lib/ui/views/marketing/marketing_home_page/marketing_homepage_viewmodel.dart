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


class MarketingHomePageViewModel extends ReactiveViewModel {
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
    await _navigationService.navigateTo(Routes.quickMessages, arguments: selectedCustomers);
//    await _navigationService.navigateTo(Routes.sendMessageViewRoute, arguments: _selectedCustomers);
  }

  // Get the services required
  ICustomerService _customerService = locator<ICustomerService>();
  final _contactService = locator<CustomerContactService>();
  final _messageService = locator<MessageService>();

  

  List<Customer> allCustomers = [];

  //List<CustomerContact> get _selectedCustomers => _contactService.selectedC;
  List<CustomerContact> get selectedCustomers => _contactService.selectedC;

  String _searchTerm = '';
  String get searchTerm => _searchTerm;
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  List<CustomerContact> get scustomers => _contactService.contactsm.where((element) => element.name.toUpperCase().contains(_searchTerm.toUpperCase())).toList();

  List<CustomerContact> get customers => _contactService.contactsm;
  Message getmsg(String id) => _messageService.getLast(id);
  List<Message> get allmessages => _messageService.allmessages;
  List<CustomerContact> get frequents => _messageService.tempc;

  //bool isFrequent(String id) => _messageService.isFrequent(id) > 2;

  void setcontact(CustomerContact cont){
    _contactService.setContact(cont);
  }

  void getContacts(){
    _contactService.getCustomermarket(StoreRepository.currentStore.id);
    _messageService.getAllMessages();
    _messageService.getFrequents(customers);
    //print(frequents);
  }

  void deleteCustomer(CustomerContact cus) {
    CustomerContact cust = new CustomerContact(
      id: cus.id,
      name: cus.name,
      phoneNumber: cus.phoneNumber,
      initials: cus.initials,
      storeid: cus.storeid,
      market: false
    );
    for(var item in allmessages) {
      if(item.cId == cus.id) {
        _messageService.deleteMessage(item);
      }
    }
    _contactService.deleteContactMarket(cus, cust);
    getContacts();
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
  bool get hasSelected => selectedCustomers.isNotEmpty;
  int get numberOfSelected => selectedCustomers.length;
  bool isSelected(CustomerContact customer) => selectedCustomers.contains(customer);
  bool get allSelected => customers.length == selectedCustomers.length;

  TextEditingController searchController = TextEditingController();
  search(String keyword) {
    _searchTerm = keyword;
    notifyListeners();
  }

  void addCustomer(CustomerContact customer) {
    _contactService.addSelected(customer);
    notifyListeners();
  }

  void deselectCustomer(CustomerContact customer) {
    _contactService.removeSelected(customer);
  }
  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
  }

  void selectAllCustomers() {
    _contactService.selectAll(customers);
  }

  void deselectAllCustomers() {
    _contactService.deselectAll();
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
    // Navigator.of(context).pushNamed(Routes.sendMessageViewRoute,arguments: selectedCustomers).then((_){
    //    final arguments = ModalRoute.of(context).settings.arguments as Map;
    //    final result = arguments['result'];
    //  allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
    //   notifyListeners();
     
    //  });
    _navigationService.navigateTo(Routes.sendMessageViewRoute);
    notifyListeners();
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
        .navigateTo(Routes.quickMessages,arguments: selectedCustomers);
//        .navigateTo(Routes.sendMessageViewRoute,arguments: _selectedCustomers);
  }

  /// View initialize and close section

  popView() {
    _navigationService.back();
  }

  returnCustomers() {
    _navigationService.back(result: selectedCustomers);
  }

  @override
  Future futureToRun() async {
   _allSelectedCustomers = await _customerService.getCustomers('1');
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_contactService, _messageService];
}
