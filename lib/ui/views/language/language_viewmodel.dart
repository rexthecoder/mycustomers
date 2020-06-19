import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();

  List<Map<String, String>> _supportedLanguages = [{'code': 'en', 'name': 'English'}];

  List get languages => _supportedLanguages;

  Future<void> setLanguage(int index) async {
    await locator<IStorageUtil>().saveString('LANGUAGE', _supportedLanguages[index]['code']);
    _navigationService.replaceWith(Routes.authenticationViewRoute);
  }

}

