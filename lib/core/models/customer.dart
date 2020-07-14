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

@JsonSerializable(nullable: true, includeIfNull: true)
class Customer {

  String get displayName => '${this.name ?? ''} ${this.lastName ?? ''}';

  String id, name, phone, email, initials;

  @JsonKey(name: 'lastname')
  String lastName;

  Customer({this.id, this.name, this.phone, this.email, this.lastName, this.initials});

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
