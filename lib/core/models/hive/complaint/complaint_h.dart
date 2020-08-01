import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaint_h.g.dart';

@HiveType(typeId: 19)
@JsonSerializable(nullable: true, includeIfNull: true)
class Complaint extends HiveObject {

  static DateTime dateFromJson(String date) {
    if (date == null) return null;
    return DateTime.tryParse(date);
  }

  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  final String subject;

  @HiveField(2)
  final String message;

  @HiveField(3)
  bool sentStatus;

  @HiveField(4)
  final String status;

  @HiveField(5)
  @JsonKey(name: 'storeOwner')
  final String sentFromId;

  @HiveField(6)
  @JsonKey(fromJson: dateFromJson)
  final DateTime date;

  @HiveField(7)
  bool deleted;

  Complaint(this.id, this.subject, this.message, this.sentStatus, this.status, this.sentFromId, this.date);

  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintToJson(this);
}
