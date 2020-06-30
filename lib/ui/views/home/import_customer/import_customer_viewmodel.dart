import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ImportCustomerViewModel extends StreamViewModel {
  // TODO: Change the functions and fields to match import contacts
  // Get the services required
  NavigationService _navigationService = locator<NavigationService>();

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();

  ImportCustomerViewModel();


  // TODO: Extract owner service init into field
  init() async {
    List<Customer> contacts = iOwnerServices.getPhoneContacts();
    _contactStream.add(contacts);
  }

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  TextEditingController searchController = TextEditingController();
  search(String keyword) async {
    _searchTerm = keyword;    
        List<Customer> contacts = iOwnerServices.getPhoneContacts();
    _contactStream.add(contacts);
  }

  /// View initialize and close section
  popView() {
    _navigationService.back();
  }


  @override
  Stream get stream => _contactStream.stream;

}