import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final IStorageUtil _storage = locator<IStorageUtil>();
  final AuthService _auth = locator<AuthService>();
 
 

  bool previewImport = false;
  // TODO:
  //    loading,
  //    authentication,
  //    permissions manager,

  Future setup() async {
    await locator.allReady();  
//    await  Future.delayed(Duration(seconds: 1));
    if (await checkLoggedIn()) _navigationService.replaceWith(Routes.mainViewRoute);
    else _navigationService.replaceWith(Routes.onboardingViewRoute);
  }

  Future<String> getEncryptionKey() async {
    return await Future.delayed(Duration(seconds: 1), () => Future.value('1890'),);
  }

  Future<Map<String, String>> getDecryptedDetails(String key) async {
    return await Future.delayed(Duration(seconds: 1),
          () => Future.value({
            'phone_number': _storage.getString(AppPreferenceKey.USER_PHONE),
            'password': _storage.getString(AppPreferenceKey.USER_PASS),
          }),
    );
  }

  Future<bool> checkLoggedIn() async {
    bool hasLoggedIn = _storage.getString(AppPreferenceKey.USER_SIGNED_IN) != null;
    Logger.d('User has ${hasLoggedIn ? '' : 'not'} logged in');
    if (!hasLoggedIn) return false;
    var key = await getEncryptionKey();
    if (key == null) return false;
    try {
      Map deets = await getDecryptedDetails(key);
      if (deets == null) throw AuthException('Incorrect password');
      await _auth.signInWithPhoneNumber(deets['phone_number'], deets['password']);
      return true;
    } on AuthException catch(e, s) {
      Logger.e(e.message, e: e, s: s);
    } catch(e, s) {
      Logger.e('Unknown error', e: e, s: s);
    }

    return false;
  }
}
