import 'package:hive/hive.dart';

// part 'assistant.g.dart';

@HiveType()
class Assistant {
  @HiveField(0)
  String _id;

  @HiveField(1)
  String storeId;

  @HiveField(2)
  String name;

  @HiveField(3)
  int pNum;

  @HiveField(4)
  int ctyCode;

  String get id => _id;
}