import 'package:hive/hive.dart';

part 'profile_h.g.dart';

@HiveType(typeId: 16, adapterName: 'ProfileAdapter')

class Profile extends HiveObject{

  @HiveField(0)
  final String image;

  @HiveField(1)
  final String name;

  // @HiveField(2)
  // final double phone;

  Profile({this.image, this.name});
}