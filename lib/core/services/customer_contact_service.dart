import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';
import '../extensions/transaction_extension.dart';

abstract class CustomerContactDataSource{
  Future<void> init();
}

@lazySingleton
class CustomerContactService extends CustomerContactDataSource with ReactiveServiceMixin {
  //static const String _boxname = "contactBox";
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.contact);
  Box<CustomerContact> get _contactBox => _hiveService.box<CustomerContact>(HiveBox.contact);
  
  //Contacts
  RxValue<List<CustomerContact>> _contacts = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get contacts => _contacts.value;

  RxValue<List<CustomerContact>> _contactsm = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get contactsm => _contactsm.value;

  RxValue<List<CustomerContact>> _selectedC = RxValue<List<CustomerContact>>(initial: []);
  RxValue<List<CustomerContact>> _allC = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get selectedC => _selectedC.value;
  List<CustomerContact> get allC => _allC.value;

  List<CustomerContact> temp = [];
  bool success, error;

  NavigationService _navigationService = locator<NavigationService>();
  //var box = Hive.openBox<CustomerContact>(_boxname);

  RxValue<CustomerContact> _contact = RxValue<CustomerContact> (initial: null);
  CustomerContact get contact => _contact.value;

  RxValue<double> _totaldebt = RxValue<double> (initial: null);
  double get totaldebt =>_totaldebt.value;

  RxValue<double> _totalcredit = RxValue<double> (initial: null);
  double get totalcredit =>_totalcredit.value;

  final _transactionService = locator<TransactionLocalDataSourceImpl>();

  var uuid = Uuid();

  CustomerContactService(){
    listenToReactiveValues([_contacts, _contact, _contactsm, _selectedC, _allC, _totalcredit, _totaldebt]);
  }

  @override
  Future<void> init() async {
    _hiveService.registerAdapter(CustomerContactAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<CustomerContact>(HiveBox.contact);
    }
  }

  void getContacts(String id) async {
    //final bbox = await box;
    _contacts.value = _contactBox.values.toList().where((element) => element.storeid == id).toList();
    print(_contacts.value.length);
    _totaldebt.value = tdebt();
    _totalcredit.value = tcredit();
    
    //_contacts.value.sort((a,b) => b.id.compareTo(a.id));
  }

  double tdebt() {
      double sum = 0;
      for(var cus in _contacts.value) {
        double tempd = 0;
        double tempc = 0;
        for(var trans in cus.transactions.helperToList()) {
          tempd += trans.amount;
          tempc += trans.paid;
        }
        sum += tempd - tempc > 0 ? tempd - tempc : 0;
      }
      return sum.abs();
    }

    double tcredit() {
      double sum = 0;
      for(var cus in _contacts.value) {
        double tempd = 0;
        double tempc = 0;
        for(var trans in cus.transactions.helperToList()) {
          tempd += trans.amount;
          tempc += trans.paid;
        }
        sum += tempc - tempd > 0 ? tempc - tempd : 0;
      }
      return sum.abs();
    }

  int getCustomerCount(String stid) {
    int sum = 0;
    for(var item in _contactBox.values.toList()) {
      //print(item.market);
      //print(item.name);
      if(item.storeid == stid && !item.market) {
        sum+=1;
      }
    }
    //print(sum == null ? 0 : sum);
    return sum;
  }

  void getCustomermarket(String stid) {
    //List<CustomerContact> temp = [];
    _contactsm.value = [];
    if(_contactBox.values.toList().length > 0) {
      for(var item in _contactBox.values.toList()) {
        if(item.storeid == stid && item.market) {
          _contactsm.value.add(item);
        }
      }
    }
  }

  void setContact(CustomerContact cont){
    _contact.value = cont;
    print(cont.id);
    //_navigationService.navigateTo(Routes.mainTransaction);
  }

  void addSelected(CustomerContact cus) {
    _allC.value =[];
    temp.add(cus);
    _selectedC.value = [...temp];
  }

  void removeSelected(CustomerContact cus) {
    temp.removeAt(temp.indexOf(cus));
    _selectedC.value = [...temp];
  }

  void removeSelectedS(CustomerContact cus) {
    CustomerContact ccus = temp.where((element) => element.name == cus.name && element.phoneNumber == cus.phoneNumber).toList()[0];
    temp.removeAt(temp.indexOf(ccus));
    _selectedC.value = [...temp];
  }

  void selectAll(List<CustomerContact> custt) {
    _selectedC.value = [];
    _allC.value =[];
    temp = [];
    _selectedC.value = custt;
    temp = custt;
  }
  void allCustomers(List<CustomerContact> custt) {
    _selectedC.value = [];
    temp = [];
    _allC.value =[];
    _allC.value =  custt;
//    temp = custt;
  }

  void deselectAll() {
    temp = [];
    _allC.value =[];
    _selectedC.value = [];
  }

  void addContact(String customerPhoneNumber, String customerName, String dropDownValue, String initials, String action, TransactionModel transaction, String stid)async {
    print(customerPhoneNumber);
    print(customerName);
    print(dropDownValue);
    if(customerName != null && customerPhoneNumber != null) {
      print('sent');
      //final bbox = await box;
      bool isStored = false;
      for(var item in _contactBox.values.toList()){
        if(item.name == customerName && item.phoneNumber == customerPhoneNumber && item.storeid == stid){
          _contact.value = item;
          isStored = true;
        }
      }
      if(isStored){
        TransactionModel ntransaction = new TransactionModel(
            tId: transaction.tId,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
        _transactionService.addTransaction(ntransaction, _contact.value);
          _navigationService.clearStackAndShow(Routes.mainViewRoute);
        //_navigationService.navigateTo(Routes.mainTransaction);
      } else {
        CustomerContact contact = new CustomerContact(
          name: customerName,
          phoneNumber: dropDownValue + customerPhoneNumber,
          id: uuid.v4(),
          initials: initials,
          storeid: stid,
          market: false,
          transactions: {},
          messages: []
        );
        _contactBox.add(contact).then((value){
          success = true;
          print(success);
          _contact.value = contact;
          print('set ${contact.id}');
          _contacts.value = _contactBox.values.toList();
          TransactionModel ntransaction = new TransactionModel(
            tId: transaction.tId,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
          _transactionService.addTransaction(ntransaction, _contact.value);
          _navigationService.clearStackAndShow(Routes.mainViewRoute);
          //_contacts.value.sort((a,b) => b.id.compareTo(a.id));
          //action == 'debtor' ? _navigationService.navigateTo(Routes.addDebt) : _navigationService.navigateTo(Routes.addCredit);
        }).catchError((err){
          error = err;
          print(error);
          print('Failed To save Contact');
          success = false;
        });
        print(_contactBox.values.toList());
      }
      
    }
  }

  Future<void> addContactmarket(String customerPhoneNumber, String customerName, String dropDownValue, String initials, String stid)async {
    print(customerPhoneNumber);
    print(customerName);
    print(dropDownValue);
    if(customerName != null && customerPhoneNumber != null) {
      print('sent');
      //final bbox = await box;
      bool isStored = false;
      for(var item in _contactBox.values.toList()){
        if(item.name == customerName && item.phoneNumber == customerPhoneNumber && item.storeid == stid){
          _contact.value = CustomerContact(
            name: item.name,
            phoneNumber: item.phoneNumber,
            id: item.id,
            initials: item.initials,
            storeid: item.storeid,
            market: item.market,
            transactions: item.transactions,
            messages: item.messages
          );
          isStored = true;
        }
      }
      if(isStored){
        print('stored');
        CustomerContact cnt = new CustomerContact(
          name: _contact.value.name,
          phoneNumber: _contact.value.phoneNumber,
          id: _contact.value.id,
          initials: _contact.value.initials,
          storeid: _contact.value.storeid,
          market: true,
          transactions: _contact.value.transactions,
          messages: _contact.value.messages
        );
        updateContact(cnt);
        _contact.value = cnt;
        //print('service'+_contact.value.name);

      } else {
        CustomerContact contact = new CustomerContact(
          name: customerName, 
          phoneNumber: dropDownValue + customerPhoneNumber, 
          id: uuid.v4(), 
          initials: initials,
          storeid: stid, 
          market: true,
          transactions: {},
          messages: []
        );
        await _contactBox.add(contact).then((value){
          success = true;
          print(success);
          _contact.value = contact;
          //print('service'+_contact.value.name);
          //print('set ${contact.id}');
          //_contacts.value = _contactBox.values.toList();
        }).catchError((err){
          error = err;
          print(error);
          print('Failed To save Contact');
          success = false;
        });
        //print(_contactBox.values.toList());
      }
      
    }
  }

  void updateContact(CustomerContact cnt)async{
    CustomerContact temp = _contactBox.values.toList().where((element) => element.id == _contact.value.id).toList()[0];
    await _contactBox.putAt(_contactBox.values.toList().indexOf(temp), cnt);
  }

  void deleteContactMarket(CustomerContact cus, CustomerContact cust) async {
    await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), cust);
  }

  void deleteContact(CustomerContact cus, String id) async {
    print(_contactBox.values.toList().indexOf(cus));
    await _contactBox.deleteAt(_contactBox.values.toList().indexOf(cus));
    getContacts(id);
  }

}