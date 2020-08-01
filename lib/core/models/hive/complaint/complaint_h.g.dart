// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComplaintAdapter extends TypeAdapter<Complaint> {
  @override
  final typeId = 19;

  @override
  Complaint read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Complaint(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
      fields[4] as String,
      fields[5] as String,
      fields[6] as DateTime,
    )..deleted = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, Complaint obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.sentStatus)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.sentFromId)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.deleted);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complaint _$ComplaintFromJson(Map<String, dynamic> json) {
  return Complaint(
    json['_id'] as String,
    json['subject'] as String,
    json['message'] as String,
    json['sentStatus'] as bool,
    json['status'] as String,
    json['storeOwner'] as String,
    Complaint.dateFromJson(json['date'] as String),
  )..deleted = json['deleted'] as bool;
}

Map<String, dynamic> _$ComplaintToJson(Complaint instance) => <String, dynamic>{
      '_id': instance.id,
      'subject': instance.subject,
      'message': instance.message,
      'sentStatus': instance.sentStatus,
      'status': instance.status,
      'storeOwner': instance.sentFromId,
      'date': instance.date?.toIso8601String(),
      'deleted': instance.deleted,
    };
