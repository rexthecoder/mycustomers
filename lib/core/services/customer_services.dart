
import 'package:mycustomers/core/models/customer.dart';

abstract class ICustomerService {

  // to add a customer
  Future<void> addCustomer(String name, String phoneNumber);

  // to get customers of a particular owner
  Future<List<Customer>> getCustomers(String ownerName);

  // to update a customers details
  Future<Customer> updateCustomerDetails(String name, String phoneNumber);

  // to delete a customer
  Future<void> deleteCustomer(String name, String phoneNumber);

}


// if the database has an ID for each of the customers,
// then the Read, Update and Delete methods can make 
// use of that property easily

class CustomerService implements ICustomerService {

  @override
  Future<void> addCustomer(String name, String phoneNumber) async {
    // TODO: implement addCustomerManually
    // awaiting API completion
  }

  @override
  Future<void> deleteCustomer(String name, String phoneNumber) async {
    // TODO: implement deleteCustomer
    // awaiting API completion
  }

  @override
  Future<List<Customer>> getCustomers(String ownerName) async {
    // TODO: implement getCustomers
    // awaiting API completion
  }

  @override
  Future<Customer> updateCustomerDetails(String name, String phoneNumber) async {
    // TODO: implement updateCustomerDetails
    // awaiting API completion
  }

}