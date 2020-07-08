// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_contact_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerContactAdapter extends TypeAdapter<CustomerContact> {
  @override
  final typeId = 1;

  @override
  CustomerContact read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerContact(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerContact obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.id);
  }
}
