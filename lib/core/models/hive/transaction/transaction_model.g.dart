// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<TransactionModel> {
  @override
  final typeId = 3;

  @override
  TransactionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      amount: fields[0] as double,
      paid: fields[1] as double,
      date: fields[2] as String,
      goods: (fields[3] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.paid)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.goods);
  }
}
