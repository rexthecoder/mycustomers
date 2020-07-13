import 'package:hive/hive.dart';

@HiveType()
class Store {
  @HiveField(0)
  String _id;

  @HiveField(1)
  String address;

  @HiveField(2)
  String name;

  @HiveField(3)
  int pNum;

  @HiveField(4)
  int ctyCode;

  @HiveField(5)
  String tagline;

  @HiveField(6)
  String ownerId;

  String get id => _id;
}