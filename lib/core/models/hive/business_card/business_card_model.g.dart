// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../business_card/business_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessCardAdapter extends TypeAdapter<_$_BusinessCard> {
  @override
  _$_BusinessCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_BusinessCard(
      storeName: fields[0] as String,
      personalName: fields[1] as String,
      phoneNumber: fields[2] as String,
      emailAddress: fields[3] as String,
      address: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_BusinessCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.storeName)
      ..writeByte(1)
      ..write(obj.personalName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.emailAddress)
      ..writeByte(4)
      ..write(obj.address);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
