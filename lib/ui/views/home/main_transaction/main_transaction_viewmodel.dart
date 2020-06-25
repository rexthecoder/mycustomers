import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class MainTransactionViewModel extends BaseViewModel{
  List purchases = [
    { 'id': 1, 'status': 'bought', 'amount': 50000, 'date': '2020-06-10 09:00:00' },
    { 'id': 2, 'status': 'paid', 'amount': 20000, 'date': '2020-06-10 11:00:00.00' },
    { 'id': 3, 'status': 'paid', 'amount': 20000, 'date': '2020-06-15 12:00:00.00' },
    { 'id': 4, 'status': 'paid', 'amount': 10000, 'date': '2020-06-15 10:00:00.00' },
    { 'id': 5, 'status': 'bought', 'amount': 80000, 'date': '2020-06-15 09:00:00.00' },
    { 'id': 6, 'status': 'paid', 'amount': 30000, 'date': '2020-06-20 11:00:00.00' },
    { 'id': 7, 'status': 'bought', 'amount': 60000, 'date': '2020-06-20 09:00:00.00' },
    { 'id': 8, 'status': 'paid', 'amount': 10000, 'date': '2020-06-25 13:00:00.00' },
  ];
  List<String> formattedate = ['10 Jun', '15 Jun', '20 Jun', '25 Jun'];
  List<String> items = ['SMS', 'Call', 'Set Reminders'];
  String date;

  int bought(){
    int sum = 0;
    for (var item in purchases) {
      if(item['status'] == 'bought') {
        sum += item['amount'];
      }
    }
    return sum;
  }

  int paid(){
    int sum = 0;
    for (var item in purchases) {
      if(item['status'] == 'paid') {
        sum += item['amount'];
      }
    }
    return sum;
  }

  bool check(String gdate) {
    final dformat = new DateFormat('d MMM');
    return dformat.format(DateTime.parse(gdate)).toString() == date;
  }

  String getDate(String gdate) {
    final dformat = new DateFormat('d MMM');
    if(dformat.format(DateTime.parse(gdate)).toString() != date) {
      date = dformat.format(DateTime.parse(gdate)).toString();
    }
    return dformat.format(DateTime.parse(gdate)).toString();
  }

  String getTime(String gdate) {
    final dformat = new DateFormat('jm');
    return dformat.format(DateTime.parse(gdate)).toString();
  }
}