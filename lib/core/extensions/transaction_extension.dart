import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';

extension HelperToList on Map {
  List<TransactionModel> helperToList() {
    if(this == null || this.isEmpty) return [];
    List<TransactionModel> temp = [];
    this.forEach((key, value) => temp.add(TransactionModel(
      tId: value.tId,
      sId: value.sId,
      amount: value.amount,
      paid: value.paid,
      duedate: value.duedate,
      boughtdate: value.boughtdate,
      paiddate: value.paiddate,
      description: value.description
    )));
    return temp;
  }
}

extension HelperToMap on List<TransactionModel> {
  Map<String, TransactionModel> helperToMap() {
    if(this == null || this.isEmpty) return {};
    return Map.fromIterable(this, key: (element) => element.tId, value: (element) => element);
  }
}