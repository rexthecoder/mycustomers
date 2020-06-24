import 'package:mycustomers/core/models/customer.dart';
import 'package:stacked/stacked.dart';

class  AddCustomerMessageViewModel extends BaseViewModel {

  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;

  List<Customer> get allCustomers => List<Customer>();


  void addCustomer(Customer customer) {
    _selectedCustomers.add(customer);
    notifyListeners();
  }

  void deselectCustomer(int idToDeselect) {
    _selectedCustomers.removeWhere((element) => element.id == idToDeselect);
    notifyListeners();
  }

  void selectAllCustomers() {
    _selectedCustomers = allCustomers;
    notifyListeners();
  }

  void deselectAllCustomers() {
    _selectedCustomers = [];
    notifyListeners();
  }
}