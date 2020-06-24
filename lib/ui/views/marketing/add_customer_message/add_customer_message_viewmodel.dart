import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddCustomerMessageViewModel extends FutureViewModel {
  // Get the services required
  NavigationService _navigationService = locator<NavigationService>();
  ICustomerService _customerService = locator<ICustomerService>();

  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;

  String _searchTerm = '';

  List<Customer> _allCustomers = [];
  List<Customer> get allCustomers => _allCustomers.where(
        (Customer customer) =>
            customer.name.contains(_searchTerm) ||
            customer.lastName.contains(_searchTerm) ||
            customer.phone.contains(_searchTerm) ||
            customer.email.contains(_searchTerm),
      );


  /// Data checking section

  bool get hasData => _allCustomers.isNotEmpty;
  bool get hasSelected => _selectedCustomers.isNotEmpty;
  int get numberOfSelected => _selectedCustomers.length;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);

  TextEditingController searchController = TextEditingController();
  search(String keyword) {
    _searchTerm = keyword;
    notifyListeners();
  }

  void addCustomer(Customer customer) {
    _selectedCustomers.add(customer);
    notifyListeners();
  }

  void deselectCustomer(Customer customer) {
    _selectedCustomers.removeWhere((element) => element.id == customer.id);
    notifyListeners();
  }

  void selectAllCustomers() {
    _selectedCustomers = _allCustomers;
    notifyListeners();
  }

  void deselectAllCustomers() {
    _selectedCustomers = [];
    notifyListeners();
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
    _allCustomers = await _customerService.getCustomers('Olumide');
  }

}
