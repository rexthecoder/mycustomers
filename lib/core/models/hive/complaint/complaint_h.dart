import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaint_h.g.dart';

@HiveType(typeId: 18)
@JsonSerializable()
class Complaint extends HiveObject {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String subject;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final bool sentStatus;

  @HiveField(4)
  final String status;

  @HiveField(5)
  @JsonKey(name: 'storeOwner')
  final String sentFromId;

  @HiveField(6)
  @JsonKey(fromJson: DateTime.parse)
  final DateTime date;

  @HiveField(7)
  bool deleted;

  Complaint(this.id, this.subject, this.message, this.sentStatus, this.status, this.sentFromId, this.date);

  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintToJson(this);
}
