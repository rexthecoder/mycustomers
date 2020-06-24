// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    json['id'] as int,
    json['customerId'] as int,
    json['amount'] as num,
    Transaction.dateFromJson(json['date'] as int),
    json['description'] as String,
    Transaction.typeFromJson(json['type'] as int),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'amount': instance.amount,
      'description': instance.description,
      'type': Transaction.typeToJson(instance.type),
      'date': Transaction.dateToJson(instance.date),
    };
