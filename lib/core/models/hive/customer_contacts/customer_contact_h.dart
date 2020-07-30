import 'package:hive/hive.dart';
import 'package:mycustomers/core/models/hive/market_message/message_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';

part 'customer_contact_h.g.dart';

@HiveType(typeId: 2, adapterName: 'CustomerContactAdapter')
class CustomerContact extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String initials;

  @HiveField(4)
  final String storeid;

  @HiveField(5)
  final bool market;

  @HiveField(6)
  final Map<String,TransactionModel> transactions;

  @HiveField(7)
  final List<Message> messages;

  CustomerContact({this.name, this.phoneNumber, this.id, this.initials, this.storeid, this.market, this.transactions, this.messages});
}