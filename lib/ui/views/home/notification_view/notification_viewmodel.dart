import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends ReactiveViewModel {

  final _logService = locator<LogsLocalDataSourceImpl>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  List<TransactionModel> get transactions => _transactionService.alltransactions;

  List<TransactionModel> reminders = [];

  List<LogH> get loglist => _logService.loglist;
  bool get notify => _logService.shouldnotify;

  void getReminders(){
    for(var item in transactions){
      //print(item.duedate == 'null');
      if(item.duedate != 'null') {
        //print(item.duedate);
        //print(DateTime.now().difference(DateTime.parse(item.duedate ?? item.paiddate)).inDays);
        if(DateTime.now().difference(DateTime.parse(item.duedate ?? item.paiddate)).inDays >= 0){
          reminders.add(item);
        }
      }
    }
    print(reminders);
    notifyListeners();
  }

  void getlogs(){
    _logService.getLogs();
    if(notify){
      _logService.setnotify();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logService];
}