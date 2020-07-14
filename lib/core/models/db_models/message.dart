import 'package:hive/hive.dart';

@HiveType()
class Message {
  @HiveField(0)
  String _id;

  @HiveField(1)
  String storeIdFrom;

  @HiveField(2)
  String customerIdTo;

  @HiveField(3)
  String content;

  @HiveField(4)
  String title;

  @HiveField(5)
  DateTime dateSent;

  @HiveField(6)
  String transactionIdFor;

  String get id => _id;
}