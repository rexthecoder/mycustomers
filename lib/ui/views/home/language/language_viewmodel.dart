import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
   
   List get languages => _supportedLanguages;

  List<Map<String, String>> _supportedLanguages = [
    {'image': 'assets/icons/uk.png','code': 'en', 'name': 'English'},
    {'image': 'assets/icons/fr.png','code': 'fr', 'name': 'Francias'},
  ];

  Future<void> setLanguage(int index) async {
    await locator<IStorageUtil>()
        .saveString('AppPreferenceKey.USER_PREF_LANGUAGE', _supportedLanguages[index]['code']);
    navigateToNext();
  }

  Future navigateToNext() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.signupViewRoute);
  }
}
