// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<TransactionModel> {
  @override
  final typeId = 4;

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
      duedate: fields[3] as String,
      boughtdate: fields[4] as String,
      paiddate: fields[5] as String,
      goods: (fields[6] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.cId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.paid)
      ..writeByte(3)
      ..write(obj.duedate)
      ..writeByte(4)
      ..write(obj.boughtdate)
      ..writeByte(5)
      ..write(obj.paiddate)
      ..writeByte(6)
      ..write(obj.goods);
  }
}
