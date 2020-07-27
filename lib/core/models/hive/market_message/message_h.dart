import 'package:hive/hive.dart';

part 'message_h.g.dart';

@HiveType(typeId: 17, adapterName: 'MessageAdapter')
class Message extends HiveObject {
  @HiveField(0)
  final String mId;

  @HiveField(1)
  final String cId;

  @HiveField(2)
  final String message;

  Message({this.mId, this.cId, this.message});
}