import 'package:flutter/cupertino.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';

class CreditorsTransactionReportViewModel extends BaseViewModel {}

class Data {
  const Data(
    this.sn,
    this.customerName,
    this.date,
    this.credit,
    this.debit,
    this.remark,
  );

  final int sn;
  final String customerName;
  final String date;
  final String remark;
  final double credit;
  final double debit;

  getIndex(int index) {
    switch (index) {
      case 0:
        return sn;
      case 1:
        return customerName;
      case 2:
        return date;
      case 3:
        return remark;
      case 4:
        return credit;
      case 5:
        return debit;
    }
  }
}
