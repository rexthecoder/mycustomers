// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerContactAdapter extends TypeAdapter<CustomerContact> {
  @override
  final typeId = 2;

  @override
  CustomerContact read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerContact(
      name: fields[0] as String,
      number: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerContact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number);
  }
}
