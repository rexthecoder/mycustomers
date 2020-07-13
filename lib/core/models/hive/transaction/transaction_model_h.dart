import 'package:hive/hive.dart';

part 'transaction_model_h.g.dart';

@HiveType(typeId: 3, adapterName: 'TransactionAdapter')

class TransactionModel extends HiveObject{

  @HiveField(0)
  final int cId;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final double paid;

  @HiveField(3)
  final String duedate;

  @HiveField(4)
  final String boughtdate;

  @HiveField(5)
  final String paiddate;

  @HiveField(6)
  final List<String> goods;

  TransactionModel({this.cId, this.amount, this.paid, this.duedate, this.boughtdate, this.paiddate, this.goods});
}