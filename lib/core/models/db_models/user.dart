import 'dart:typed_data';

import 'package:hive/hive.dart';

// part 'assistant.g.dart';

@HiveType()
class User {
  @HiveField(0)
  String _id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String name;

  @HiveField(3)
  int pNum;

  @HiveField(4)
  int ctyCode;

  @HiveField(5)
  String fName;

  @HiveField(6)
  String lName;

  @HiveField(7)
  String pwd;

  @HiveField(8)
  Uint8List displayPic;

  String get id => _id;
}