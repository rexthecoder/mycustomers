import 'package:hive/hive.dart';

part 'customer_contact.g.dart';

@HiveType(typeId: 3, adapterName: 'CustomerContactAdapter')
class CustomerContact{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String number;

  CustomerContact({this.name, this.number});
}