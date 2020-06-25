import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final int id;
  final String name, phone, email;

  @JsonKey(name: 'lastname')
  final String lastName;

  Customer(this.id, this.name, this.phone, this.email, this.lastName);

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}