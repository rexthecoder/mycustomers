import 'package:hive/hive.dart';

part 'transaction_model_h.g.dart';

@HiveType(typeId: 2, adapterName: 'TransactionAdapter')
class TransactionModel{

  @HiveField(0)
  final int cId;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final double paid;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final List<String> goods;

  TransactionModel({this.cId, this.amount, this.paid, this.date, this.goods});
}