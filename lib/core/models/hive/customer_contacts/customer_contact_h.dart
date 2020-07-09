import 'package:hive/hive.dart';

part 'customer_contact_h.g.dart';

@HiveType(typeId: 2, adapterName: 'CustomerContactAdapter')
class CustomerContact{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final int id;

  CustomerContact({this.name, this.phoneNumber, this.id});
}