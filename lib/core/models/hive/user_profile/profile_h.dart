import 'package:hive/hive.dart';

part 'profile_h.g.dart';

@HiveType(typeId: 16, adapterName: 'ProfileAdapter')

class Profile extends HiveObject{

  @HiveField(0)
  final String image;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String sId;

  Profile({this.image, this.name, this.sId});
}