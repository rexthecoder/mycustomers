import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

abstract class MessasageDataSource with ReactiveServiceMixin {
  List<Message> get messages;

  List<Message> get allmessages;

  List<CustomerContact> get tempc;

  Message get lastmsg;

  void getAllMessages();

  void getFrequents(List<CustomerContact> customers);

  void getMessage(CustomerContact cus);

  Message getLast(CustomerContact cus);

  void addMessage(String msg, CustomerContact cus);

  void deleteMessage(Message msg, CustomerContact cus);

  void deleteAllMessage(CustomerContact cus);
}

@lazySingleton
class MessageService extends MessasageDataSource {
  final _hiveService = locator<HiveInterface>();

  //bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.message);
  //Box<Message> get _messageBox => _hiveService.box<Message>(HiveBox.message);

  Box<CustomerContact> get _contactBox => _hiveService.box<CustomerContact>(HiveBox.contact);

  RxValue<List<Message>> _messages = RxValue<List<Message>>(initial: []);
  @override
  List<Message> get messages => _messages.value;

  RxValue<List<Message>> _allmessages = RxValue<List<Message>>(initial: []);
  @override
  List<Message> get allmessages => _allmessages.value;

  RxValue<List<CustomerContact>> _tempc = RxValue<List<CustomerContact>>(initial: []);
  @override
  List<CustomerContact> get tempc => _tempc.value;

  RxValue<Message> _lastmsg = RxValue<Message>(initial: null);
  @override
  Message get lastmsg => _lastmsg.value;

  var uuid = Uuid();

  MessageService(){
    listenToReactiveValues([_messages, _allmessages, _tempc]);
  }

  // Future<void> init() async {
  //   _hiveService.registerAdapter(MessageAdapter());

  //   if (!_isBoxOpen) {
  //     await _hiveService.openBox<Message>(HiveBox.message);
  //   }
  // }

  @override
  void getAllMessages() {
    _allmessages.value = [];
    for(var cont in _contactBox.values.toList()) {
      _allmessages.value = [..._allmessages.value, ...cont.messages];
    }
    //print(_allmessages.value);
  }

  @override
  void getFrequents(List<CustomerContact> customers) {
    //List<Message> temp = [];
    //List<CustomerContact> tempc = [];
    _tempc.value = [];
    for (var item in customers) {
      if(item.messages.length>2) {
        _tempc.value.add(item);
      }
    }
  }

  @override
  void getMessage(CustomerContact cus) {
    //List<Message> temp = [];
    _messages.value = cus.messages;
  }

  @override
  Message getLast(CustomerContact cus) {
    return cus.messages.length > 0 ? cus.messages.last : null;
  }

  // int isFrequent(String id) {
  //   List<Message> temp = [];
  //   for(var item in _messageBox.values.toList()) {
  //     if(item.cId == id) {
  //       temp.add(item);
  //     }
  //   }
  //   return temp.length;
  // }

  @override
  void addMessage(String msg, CustomerContact cus)async {
    Message mesg = new Message(
      mId: uuid.v4(),
      cId: cus.id,
      message: msg
    );
    CustomerContact temp = cus;
    temp.messages.add(mesg);
    await _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);
  }

  @override
  void deleteMessage(Message msg, CustomerContact cus)async {
    CustomerContact temp = cus;
    temp.messages.removeAt(temp.messages.indexOf(msg));
    _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);
    //await _messageBox.deleteAt(_messageBox.values.toList().indexOf(msg));
  }

  @override
  void deleteAllMessage(CustomerContact cus)async {
    CustomerContact temp = cus;
    temp.messages.clear();
    _contactBox.putAt(_contactBox.values.toList().indexOf(cus), temp);
    //await _messageBox.deleteAt(_messageBox.values.toList().indexOf(msg));
  }
}