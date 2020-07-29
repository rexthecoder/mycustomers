import 'dart:math';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/models/hive/customer/customer_h.dart';

part 'customer.g.dart';

const customerNames = [
  'Olumide',
  'John',
  'Olamide',
  'Ufedojo',
  'Eternity',
  'Mark',
];

const customerLastNames = [
  'Isaac',
  'Ezekiel',
  'Smute',
  'Jordan',
  'Essien',
];

@JsonSerializable(nullable: true, includeIfNull: true)

@HiveType(typeId: 18, adapterName: 'ContactAdapter')

class Customer extends HiveObject {

  String get displayName => '${this.name ?? ''} ${this.lastName ?? ''}';

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String email;

  @HiveField(4)
  String initials;

  @JsonKey(name: 'lastname')
  @HiveField(5)
  String lastName;

  Customer({this.id, this.name, this.phone, this.email, this.lastName, this.initials});

  factory Customer.fromCustomerH(CustomerH customerH) {
    
    String name = customerH.name.split(' ')[0];
    String lastName = customerH.name.split(' ').length < 2 ? '' : customerH.name.split(' ')[0];
    String initials = customerH.name.split(' ').length < 2 ? name[0] : '${name[0]} ${lastName[0]}';
    return Customer(
      phone: '${customerH.ctyCode}${customerH.pNum}',
      id: customerH.id,
      email: customerH.email,
      name: name,
      lastName: lastName,
      initials: initials
    );
}

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer.random()
      : id = Random().nextInt(100000).toString(),
        name = customerNames[Random().nextInt(customerNames.length)],
        phone = '+3248163259874',
        email = 'example@domain.com',
        lastName = customerLastNames[Random().nextInt(customerLastNames.length)];
}
