import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/models/customer.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final int id;
  final String email;
  final Customer customer;

  User(this.id, this.email,this.customer);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}