
abstract class ICustomerServices{

  // to add a customer
  void addCustomer(String name, String phoneNumber) {} 

  // to get customers of a particular owner
  void getCustomers(String ownerName) {} 

  // to update a customers details
  void updateCustomerDetails(String name, String phoneNumber) {} 

  // to delete a customer
  void deleteCustomer(String name, String phoneNumber) {} 

}


// if the database has an ID for each of the customers,
// then the Read, Update and Delete methods can make 
// use of that property easily

class CustomerServices implements ICustomerServices {

  @override
  void addCustomer(String name, String phoneNumber) async{
    // TODO: implement addCustomerManually
    // awaiting API completion
  }

  @override
  void deleteCustomer(String name, String phoneNumber) {
    // TODO: implement deleteCustomer
    // awaiting API completion
  }

  @override
  void getCustomers(String ownerName) {
    // TODO: implement getCustomers
    // awaiting API completion
  }

  @override
  void updateCustomerDetails(String name, String phoneNumber) {
    // TODO: implement updateCustomerDetails
    // awaiting API completion
  }

}