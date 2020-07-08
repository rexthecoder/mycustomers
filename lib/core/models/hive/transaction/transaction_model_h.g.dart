// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<TransactionModel> {
  @override
  TransactionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      cId: fields[0] as int,
      amount: fields[1] as double,
      paid: fields[2] as double,
      date: fields[3] as String,
      goods: (fields[4] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.paid)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.goods);
  }
  @override
  int get typeId => 3;
}
