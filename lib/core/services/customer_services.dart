
abstract class ICustomerServices{

  // to add a customer
  void createCustomer(String name, String phoneNumber, String email) {} 

  // to get customers of a particular owner
  void getCustomers(String ownerName) {} 

  // to get customers of a particular owner
  void getCustomerbyId(String custId) {} 

  // to update a customers details
  void updateCustomerDetails(String name, String phoneNumber, String email) {} 

  // to delete a customer
  void deleteCustomer(String customerId) {} 

}


// if the database has an ID for each of the customers,
// then the Read, Update and Delete methods can make 
// use of that property easily

class CustomerServices implements ICustomerServices {
  @override
  void createCustomer(String name, String phoneNumber, String email) {
    // TODO: implement createCustomer
  }

  @override
  void deleteCustomer(String customerId) {
    // TODO: implement deleteCustomer
  }

  @override
  void getCustomerbyId(String customerId) {
    // TODO: implement getCustomerbyId
  }

  @override
  void getCustomers(String ownerName) {
    // TODO: implement getCustomers
  }

  @override
  void updateCustomerDetails(String name, String phoneNumber, String email) {
    // TODO: implement updateCustomerDetails
  }


}