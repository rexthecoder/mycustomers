import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/enums/transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final int id, customerId;
  final num amount;
  final String description;

  @JsonKey(fromJson: typeFromJson, toJson: typeToJson)
  final TransactionType type;

  @JsonKey(toJson: dateToJson, fromJson: dateFromJson)
  final DateTime date;

  Transaction(this.id, this.customerId, this.amount, this.date, this.description, this.type);

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static TransactionType typeFromJson(int type) {
    return TransactionType.values[type + 1];
  }

  static int dateToJson(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  static DateTime dateFromJson(int timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(timestamp);
  }

  static int typeToJson(TransactionType type) {
    return type.index + 1;
  }
}