import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/core/services/user_services.dart';
import 'package:mycustomers/core/services/store_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/exceptions/update_exception.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

class BusinessViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final StoreService _storeService = locator<StoreService>();
  final DialogService _dialogService = locator<DialogService>();


  Future<void> navigateToNext() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true, transition: 'cupertino', duration: Duration(seconds: 2));

  }

  updateUser(String name, String businessName) async {
    bool busy = true;
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(title: 'please hold on while we try to create your store');
    try {

      await _userService.createAssistant(name);
      await _storeService.createStore(businessName);
      _dialogService.completeDialog(DialogResponse());
      showToastCustom(message: 'Your store has been created successfully', success: true,);
      busy = false;
      navigateToNext();
    } on UpdateException catch(e, s) {
      showToastCustom(message: e.message,);
      Logger.e(e.message, e: e, s: s);
    } on CreateException catch(e, s) {
      showToastCustom(message: e.message,);
      Logger.e(e.message, e: e, s: s);
    } catch (e, s) {
      Logger.e('Unknown Error', e: e, s: s);
      showToastCustom(message: 'An error occured while creating store',);
    }
    if (busy) _dialogService.completeDialog(DialogResponse());
  }

bool btnColor = true;

   void activeBtn() {
    btnColor = !btnColor;
    notifyListeners();
  }

}
