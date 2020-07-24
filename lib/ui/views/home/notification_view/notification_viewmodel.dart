import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class NotificationViewModel extends ReactiveViewModel {

  final _logService = locator<LogsLocalDataSourceImpl>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  final _contactService = locator<CustomerContactService>();
  List<TransactionModel> get transactions => _transactionService.alltransactions;
  List<CustomerContact> get contacts => _contactService.contacts;

  List<TransactionModel> reminders = [];

  List<LogH> get loglist => _logService.loglist;
  bool get notify => _logService.shouldnotify;
  bool shownotify = false;

  void getReminders(){
    final dformat = new DateFormat('dd/MM/yyyy');
    for(var item in transactions){
      if(item.duedate != 'null') {
        if(DateTime.now().difference(DateTime.parse(item.duedate ?? item.paiddate)).inDays == 0 && dformat.format(DateTime.parse(item.duedate ?? item.paiddate)) == dformat.format(DateTime.now()) && (item.amount > item.paid || item.paid > item.amount)){
          reminders.add(item);
        }
      }
    }
    if(reminders.length > 0) {
      shownotify = true;
    }
    print(reminders);
    notifyListeners();
  }

  String getName(String id) {
    for(var item in contacts) {
      if(item.id == id) {
        return item.name;
      }
    }
    return '';
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