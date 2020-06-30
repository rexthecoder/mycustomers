import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/models/customer.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String userRole;
  final phone;
  

  User(this.id, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}