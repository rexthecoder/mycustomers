import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:uuid/uuid.dart';

class MessageService {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.message);
  Box<Message> get _messageBox => _hiveService.box<Message>(HiveBox.message);

  var uuid = Uuid();

  Future<void> init() async {
    _hiveService.registerAdapter(MessageAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Message>(HiveBox.message);
    }
  }

  List<Message> getAllMessages() {
    return _messageBox.values.toList();
  }

  List<Message> getMessage(String id) {
    List<Message> temp = [];
    if(_messageBox.values.toList().length > 0) {
      for(var item in _messageBox.values.toList()) {
        if(item.cId == id) {
          temp.add(item);
        }
      }
    }
    return temp;
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
}