import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:stacked_services/stacked_services.dart';

class DebtListViewModel extends BaseViewModel {
  
  MainTransactionViewModel transaction = MainTransactionViewModel();

  final RemindersViewModel reminders = RemindersViewModel();

  final NavigationService _navigationService = locator<NavigationService>();

  final _transactionService = locator<TransactionLocalDataSourceImpl>();

  void navigateToSchedule(TransactionModel item) {
    _transactionService.setTransaction(item);
    _navigationService.navigateTo(Routes.scheduleSingleDebt);
  }

  void navigateToSendMessage(TransactionModel item) {
    _transactionService.setTransaction(item);
    _navigationService.navigateTo(Routes.sendSingleDebt);
  }
}
