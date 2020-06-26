import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

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

@JsonSerializable()
class Customer {
  final int id;
  final String name, phone, email;

  @JsonKey(name: 'lastname')
  final String lastName;

  Customer(this.id, this.name, this.phone, this.email, this.lastName);

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer.random()
      : id = Random().nextInt(100000),
        name = customerNames[Random().nextInt(customerNames.length)],
        phone = '+3248163259874',
        email = 'example@domain.com',
        lastName = customerLastNames[Random().nextInt(customerLastNames.length)];
}
