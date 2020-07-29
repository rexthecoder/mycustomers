import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_remindersview/reminders_view_model.dart';

class DebtListViewModel extends BaseViewModel {
  bool _isSelected = true;
  bool get isSelected => _isSelected;
  MainTransactionViewModel transaction = MainTransactionViewModel();
 final RemindersViewModel reminders = RemindersViewModel();


}
