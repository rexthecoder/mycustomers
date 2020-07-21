import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class CustomerContactService with ReactiveServiceMixin {
  static const String _boxname = "contactBox";
  RxValue<List<CustomerContact>> _contacts = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get contacts => _contacts.value;
  bool success, error;

  NavigationService _navigationService = locator<NavigationService>();
  var box = Hive.openBox<CustomerContact>(_boxname);

  RxValue<CustomerContact> _contact = RxValue<CustomerContact> (initial: null);
  CustomerContact get contact => _contact.value;

  final _transactionService = locator<TransactionLocalDataSourceImpl>();

  var uuid = Uuid();

  CustomerContactService(){
    listenToReactiveValues([_contacts, _contact]);
  }

  void getContacts() async {
    final bbox = await box;
    _contacts.value = bbox.values.toList();
    _contacts.value.sort((a,b) => b.id.compareTo(a.id));
  }

  void setContact(CustomerContact cont){
    _contact.value = cont;
    print(cont.id);
    _navigationService.navigateTo(Routes.mainTransaction);
  }

  void addContact(String customerPhoneNumber, String customerName, String dropDownValue, String initials, String action, TransactionModel transaction)async {
    print(customerPhoneNumber);
    print(customerName);
    print(dropDownValue);
    if(customerName != null && customerPhoneNumber != null) {
      print('sent');
      final bbox = await box;
      bool isStored = false;
      for(var item in bbox.values.toList()){
        if(item.name == customerName && item.phoneNumber == customerPhoneNumber){
          _contact.value = CustomerContact(name: item.name, phoneNumber: item.phoneNumber, id: item.id, initials: item.initials);
          isStored = true;
        }
      }
      if(isStored){
        TransactionModel ntransaction = new TransactionModel(
            cId: contact.id,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
        _transactionService.addTransaction(ntransaction);
          _navigationService.navigateTo(Routes.mainViewRoute);
        //_navigationService.navigateTo(Routes.mainTransaction);
      } else {
        CustomerContact contact = new CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: uuid.v4(), initials: initials);
        bbox.add(contact).then((value){
          success = true;
          print(success);
          _contact.value = CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: uuid.v4(), initials: initials);
          print('set ${contact.id}');
          _contacts.value = bbox.values.toList();
          TransactionModel ntransaction = new TransactionModel(
            cId: contact.id,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
          _transactionService.addTransaction(ntransaction);
          _navigationService.navigateTo(Routes.mainViewRoute);
          //_contacts.value.sort((a,b) => b.id.compareTo(a.id));
          //action == 'debtor' ? _navigationService.navigateTo(Routes.addDebt) : _navigationService.navigateTo(Routes.addCredit);
        }).catchError((err){
          error = err;
          print(error);
          print('Failed To save Contact');
          success = false;
        });
        print(bbox.values.toList());
      }
      
    }
  }

}