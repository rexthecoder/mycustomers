import 'package:hive/hive.dart';

enum TransactionType { debit, credit }

@HiveType()
class Transaction {
  @HiveField(0)
  String _id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime dateAdded;

  @HiveField(3)
  TransactionType type;

  @HiveField(4)
  String customerIdFrom;

  @HiveField(5)
  DateTime dateDue;

  @HiveField(6)
  bool isCleared;

  @HiveField(7)
  String storeIdFor;

  @HiveField(8)
  String idCreatedBy;

  @HiveField(9)
  String idClearedBy;

  String get id => _id;
  
}