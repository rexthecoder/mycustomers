// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/themes.dart' as _theme;
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';

class SettingManagerModel extends BaseViewModel {

  IStorageUtil _su = locator<IStorageUtil>();
  final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();

  // TODO: implement getter properly
  bool get isDarkTheme => _su.getBool('IS_DARK_THEME') ?? WidgetsBinding.instance.window.platformBrightness == Brightness.dark/*(MediaQuery.of(_context).platformBrightness == Brightness.dark) */ ?? false;


  // Language settings
  Locale get locale {
    Locale loc;
    String _langCode = _su.getString(AppPreferenceKey.SELECTED_LOCALE);
    if (_langCode != null && _langCode.isNotEmpty) loc = Locale.fromSubtags(languageCode: _langCode);
    // print('Fetching locale...\nValue is ${loc?.languageCode}');
    return loc;
  }

  Future<void> setLocale(String localeCode) async {
    // print('Setting locale...\nValue is $localeCode');
    await _su.saveString(AppPreferenceKey.SELECTED_LOCALE, localeCode);
    showToastCustom(
      message: 'Your language has been changed successfully',
      success: true,
    );
    _logService.getValues(null, DateTime.now(), 'lang-change', '', false);
    notifyListeners();
  }


  // Theme settings
  ThemeData get theme => isDarkTheme ? _theme.darkMaterialTheme : _theme.primaryMaterialTheme;

  Future<void> setTheme() async {
    var newTheme = !isDarkTheme;
    await _su.saveBool('IS_DARK_THEME', newTheme);
    notifyListeners();
    // print('Notified listeners. Dark theme is: $isDarkTheme');
  }
}
