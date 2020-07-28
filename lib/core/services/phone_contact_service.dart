import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class PhoneContactService with ReactiveServiceMixin {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.phoneContact);
  Box<Customer> get _phoneContactBox => _hiveService.box<Customer>(HiveBox.phoneContact);

  RxValue<List<Customer>> _contact = RxValue<List<Customer>>(initial: []);
  List<Customer> get contact => _contact.value;

  PhoneContactService(){
    listenToReactiveValues([_contact]);
  }

  Future<void> init() async {
    _hiveService.registerAdapter(ContactAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Customer>(HiveBox.phoneContact);
    }
  }

  int contactsCount() {
    return _phoneContactBox.values.toList().length;
  }

  void getContacts() {
    _contact.value = _phoneContactBox.values.toList();
    //print(_phoneContactBox.values.toList());
  }

  void addCustomer(Customer cus) {
    print(cus.displayName);
    _phoneContactBox.add(cus);
  }
}