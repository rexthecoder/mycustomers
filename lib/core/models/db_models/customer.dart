import 'package:hive/hive.dart';

@HiveType()
class Customer {
  @HiveField(0)
  String _id;

  @HiveField(1)
  String storeIdFor;

  @HiveField(2)
  String name;

  @HiveField(3)
  int pNum;

  @HiveField(4)
  int ctyCode;

  String get id => _id;
}