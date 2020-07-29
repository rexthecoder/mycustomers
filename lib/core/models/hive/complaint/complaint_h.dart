import 'package:hive/hive.dart';

@HiveType(typeId: 18)
class Complaint {
  @HiveField(0)
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
  final String sentFromId;

  Complaint(this.id, this.subject, this.message, this.sentStatus, this.status, this.sentFromId);
}
