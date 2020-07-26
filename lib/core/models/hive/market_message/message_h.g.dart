// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final typeId = 17;

  @override
  Message read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      mId: fields[0] as String,
      cId: fields[1] as String,
      message: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mId)
      ..writeByte(1)
      ..write(obj.cId)
      ..writeByte(2)
      ..write(obj.message);
  }
}
