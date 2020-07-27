import 'dart:async';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/message_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/owner_services.dart';

class MessageViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final  _contactService = locator<CustomerContactService>();
  final  _messageService = locator<MessageService>();
  TextEditingController titleController =TextEditingController();
  TextEditingController messageController =TextEditingController();

  List<CustomerContact> get selectedCustomers => _contactService.selectedC;
  String tit = '';
  String body = '';

  void select(Customer cust){
    CustomerContact temp = new CustomerContact(
      name: cust.displayName,
      phoneNumber: cust.phone,
      initials: cust.initials,
    );
    _contactService.addSelected(temp);
  }

  void deselect(Customer cust){
    CustomerContact temp = new CustomerContact(
      name: cust.displayName,
      phoneNumber: cust.phone,
      initials: cust.initials,
    );
    _contactService.removeSelectedS(temp);
  }

  bool checkselected(String name, String phone) {
    for(var item in selectedCustomers) {
      if(item.name == name && item.phoneNumber == phone) return true;
    }
    return false;
  }

  void send()async{
    List<CustomerContact> hold = [];
    for(var item in selectedCustomers){
      await _contactService.addContactmarket(item.phoneNumber, item.name, '', item.initials, StoreRepository.currentStore.id);
      //print(_contactService.contact.name);
      hold.add(_contactService.contact);
    }
    _contactService.selectAll(hold);
    for(var item in selectedCustomers) {
      //print(item.name);
      _messageService.addMessage(tit+', '+body, item.id);
    }
  }

  void setTitle(String value) {
    tit = value;
    notifyListeners();
  }

  void setBody(String value) {
    body = value;
    notifyListeners();
  }

  PermissionService _permission =  locator<IPermissionService>();
  Future<bool> checkPermission() async {
     return await _permission.getContactsPermission(); 
  }
  Future requestPermission() async{
    return await [Permission.contacts].request();
  }

  Future returnHome() async {
    _contactService.deselectAll();
    _navigationService.clearStackAndShow('/main');
  }

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  List<Customer> allCustomers = List<Customer>();
  bool _busy = true;
  bool get isLoadBusy => _busy;
  MessageViewModel();
  Iterable<Contact> contacts;
  List<Customer> _selectedCustomers = [];
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  init({String query}) async {
   allCustomers.clear();
    for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
      print('Iterate');
      if (_busy) {
        _busy = false;
        notifyListeners();
      }
      allCustomers.add(customer);
      _contactStream.add(allCustomers);
    }
  }

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);
  void selectCustomer(Customer customer) {
    //_newSelectedCustomers.add(customer);
    print(_selectedCustomers.length);
    notifyListeners();
  }



  void setQuickText(title, message){
    if(title.length !=0){
      titleController.text= title;
      tit = title;
      messageController.text = message;
      body = message;
    }
    
  }

  /// View initialize and close section

  popView() {
    _navigationService.back();
  }



  TextEditingController searchController = TextEditingController();
  search(String keyword) async {
    _searchTerm = keyword;
    _busy = true;
    notifyListeners();
    init(query: _searchTerm);
  }

  @override
  Stream get stream => _contactStream.stream;

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_contactService, _messageService];
}
