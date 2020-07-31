import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:stacked_services/stacked_services.dart';

class DebtListViewModel extends BaseViewModel {

  String date;
  
  final _customerContactService = locator<CustomerContactService>();
  CustomerContact get contact => _customerContactService.contact;

  final _transactionsService = locator<TransactionLocalDataSourceImpl>();
  List<TransactionModel> get transactions =>
      _transactionsService.transactions.reversed.toList();

  final _businessService = locator<BussinessSettingService>();
  CountryCurrency get currency => _businessService.curren;

  final NavigationService _navigationService = locator<NavigationService>();

  final _transactionService = locator<TransactionLocalDataSourceImpl>();

  Future<void> navigateToSendMessage() async {
    await _navigationService.navigateTo(Routes.sendNotificationMessage);
  }

  Future<void> navigateToSchedule() async {
    await _navigationService.navigateTo(Routes.scheduleNotifications);
  }

  void navigateToScheduleSingleDebt(TransactionModel item) {
    _transactionService.setTransaction(item);
    _navigationService.navigateTo(Routes.scheduleSingleDebt);
  }

  void navigateToSendSingleDebt(TransactionModel item) {
    _transactionService.setTransaction(item);
    _navigationService.navigateTo(Routes.sendSingleDebt);
  }

List<String> get formattedate =>  List<String>.from(_transactionService.formattedate.reversed);

  double getamount(double amt) {
    return amt;
  }
  
  int bought(){
    int sum = 0;
    for (var item in transactions) {
      if (item.amount != 0) {
        sum += item.amount.round();
      }
    }
    return sum;
  }

  String getDate(String gdate) {
    final dformat = new DateFormat('d MMM');
    if (dformat.format(DateTime.parse(gdate)).toString() != date) {
      date = dformat.format(DateTime.parse(gdate)).toString();
    }
    return dformat.format(DateTime.parse(gdate)).toString();
  }
  
   String getdDate(String gdate) {
    final dformat = new DateFormat('dd/MM/yyyy');
    if (dformat.format(DateTime.parse(gdate)).toString() != date) {
      date = dformat.format(DateTime.parse(gdate)).toString();
    }
    return dformat.format(DateTime.parse(gdate)).toString();
  }

   String getTime(String gdate) {
    final dformat = new DateFormat('jm');
    return dformat.format(DateTime.parse(gdate)).toString();
  }
}
