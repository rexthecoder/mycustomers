import 'package:hive/hive.dart';

part 'transaction_model_h.g.dart';

@HiveType(typeId: 3, adapterName: 'TransactionAdapter')

class TransactionModel extends HiveObject{

  @HiveField(0)
  final String tId;

  @HiveField(1)
  final String sId;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final double paid;

  @HiveField(4)
  final String duedate;

  @HiveField(5)
  final String boughtdate;

  @HiveField(6)
  final String paiddate;

  @HiveField(7)
  final String description;

  TransactionModel({this.tId, this.sId, this.amount, this.paid, this.duedate, this.boughtdate, this.paiddate, this.description});

  TransactionModel.fromjson(Map<String, dynamic> json) : 
    tId = json['tId'],
    sId = json['sId'],
    amount = json['amount'],
    paid = json['paid'],
    duedate = json['duedate'],
    boughtdate = json['boughtdate'],
    paiddate = json['paiddate'],
    description = json['description'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tId'] = this.tId;
    data['sId'] = this.sId;
    data['amount'] = this.amount;
    data['paid'] = this.paid;
    data['duedate'] = this.duedate;
    data['boughtdate'] = this.boughtdate;
    data['paiddate'] = this.paiddate;
    data['description'] = this.description;
  }
}