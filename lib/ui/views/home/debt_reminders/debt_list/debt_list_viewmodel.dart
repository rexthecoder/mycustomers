import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';

class DebtListViewModel extends BaseViewModel {
  MainTransactionViewModel transaction = MainTransactionViewModel();
  final RemindersViewModel reminders = RemindersViewModel();
}
