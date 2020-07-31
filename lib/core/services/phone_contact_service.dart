import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

abstract class PhoneContactDataSource with ReactiveServiceMixin {
  Future<void> init();
  
  List<Customer> get contact;

  bool get busy;

  bool get permission;

  int contactsCount();

  void getContacts();

  Future<void> deleteall();

  Future<void> addCustomer(Customer cus);
}

@lazySingleton
class PhoneContactService extends PhoneContactDataSource {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.phoneContact);
  Box<Customer> get _phoneContactBox => _hiveService.box<Customer>(HiveBox.phoneContact);

  RxValue<List<Customer>> _contact = RxValue<List<Customer>>(initial: []);
  @override
  List<Customer> get contact => _contact.value;

  RxValue<bool> _busy = RxValue<bool>(initial: false);
  @override
  bool get busy => _busy.value;

  RxValue<bool> _permission = RxValue<bool>(initial: false);
  @override
  bool get permission => _permission.value;

  PhoneContactService(){
    listenToReactiveValues([_contact, _busy]);
  }

  @override
  Future<void> init() async {
    _hiveService.registerAdapter(ContactAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Customer>(HiveBox.phoneContact);
    }
  } 

  @override
  int contactsCount() {
    return _phoneContactBox.values.toList().length;
  }

  @override
  void getContacts() {
    _busy.value = true;
    _contact.value = _phoneContactBox.values.toList();
    _busy.value = false;
    //print(_phoneContactBox.values.toList());
  }

  @override
  Future<void> deleteall()async {
    await _phoneContactBox.clear();
  }

  @override
  Future<void> addCustomer(Customer cus)async {
    _busy.value = true;
    print(cus.displayName);
    await _phoneContactBox.add(cus);
  }
}