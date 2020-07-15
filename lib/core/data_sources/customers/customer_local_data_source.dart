import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/db_models/customer.dart';

abstract class StoresLocalDataSource {
  Future<void> init();
}

class StoresLocalDataSourceImpl implements StoresLocalDataSource {

  var box = Hive.box<Customer>('customerBox');

  List<Customer> getAllCustomers() => box.values.toList();
  

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
  }

  Future<void> addCustomer(Customer customer) async {
    
    await box.add(customer);

  }

  dynamic getCustomer(String customerId) {

    Iterable<Customer> customers = box.values;
    try {

      Customer customer = customers.singleWhere((element) => element.id == customerId);
      return customer;

    } catch (e) {
      return e;
    }
    
  }

  void updateCustomerDetails(String customerId, {int countryCode, int phoneNumber, String name, String storeId}){
    
    List<Customer> customers = box.values.toList();
  
    int index = customers.indexWhere((element) => element.id == customerId);
    customers.forEach((customer) {
      if(customer.id == customerId){
        customer.ctyCode = countryCode ?? customer.ctyCode;
        customer.pNum = phoneNumber ?? customer.pNum;
        customer.name = name ?? customer.name;
        customer.storeIdFor = storeId ?? customer.storeIdFor;
        box.putAt(index, customer);
      }
     });
    
  }

  dynamic deleteCustomer(String customerId) {

    List<Customer> customers = box.values.toList();
    try {

      int index = customers.indexWhere((element) => element.id == customerId);
      box.deleteAt(index);

    } catch (e) {
      return e;
    }
    
  }
  
}
