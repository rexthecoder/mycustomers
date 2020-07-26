import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class MessageService with ReactiveServiceMixin{
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.message);
  Box<Message> get _messageBox => _hiveService.box<Message>(HiveBox.message);

  RxValue<List<Message>> _messages = RxValue<List<Message>>(initial: []);
  List<Message> get messages => _messages.value;

  RxValue<List<Message>> _allmessages = RxValue<List<Message>>(initial: []);
  List<Message> get allmessages => _allmessages.value;

  RxValue<List<CustomerContact>> _tempc = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get tempc => _tempc.value;

  RxValue<Message> _lastmsg = RxValue<Message>(initial: null);
  Message get lastmsg => _lastmsg.value;

  var uuid = Uuid();

  MessageService(){
    listenToReactiveValues([_messages, _allmessages, _tempc]);
  }

  Future<void> init() async {
    _hiveService.registerAdapter(MessageAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Message>(HiveBox.message);
    }
  }

  void getAllMessages() {
    _allmessages.value = _messageBox.values.toList();
    //print(_allmessages.value);
  }

  void getFrequents(List<CustomerContact> customers) {
    List<Message> temp = [];
    //List<CustomerContact> tempc = [];
    _tempc.value = [];
    for (var item in customers) {
      for(var msg in allmessages) {
        if(item.id == msg.cId) {
          temp.add(msg);
          if(temp.length > 2) {
            _tempc.value.add(item);
            break;
          }
        }
      }
    }
  }

  void getMessage(String id) {
    //List<Message> temp = [];
    _messages.value = [];
    if(_messageBox.values.toList().length > 0) {
      for(var item in _messageBox.values.toList()) {
        if(item.cId == id) {
          _messages.value.add(item);
        }
      }
    }
  }

  Message getLast(String id) {
    List<Message> temp = [];
    if(_messageBox.values.toList().length > 0) {
      for(var item in _messageBox.values.toList()) {
        if(item.cId == id) {
          temp.add(item);
        }
      }
    }
    return temp.length > 0 ? temp.last : null;
  }

  int isFrequent(String id) {
    List<Message> temp = [];
    for(var item in _messageBox.values.toList()) {
      if(item.cId == id) {
        temp.add(item);
      }
    }
    return temp.length;
  }

  void addMessage(String msg, String id)async {
    Message mesg = new Message(
      mId: uuid.v4(),
      cId: id,
      message: msg
    );
    await _messageBox.add(mesg);
  }

  void deleteMessage(Message msg)async {
    await _messageBox.deleteAt(_messageBox.values.toList().indexOf(msg));
  }
}