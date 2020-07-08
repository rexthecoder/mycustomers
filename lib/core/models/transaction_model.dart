import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2, adapterName: 'TransactionAdapter')
class TransactionModel{

  @HiveField(0)
  final double amount;

  @HiveField(1)
  final double paid;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final List<String> goods;

  TransactionModel({this.amount, this.paid, this.date, this.goods});
}