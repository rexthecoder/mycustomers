// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/themes.dart' as _theme;
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';

class ThemeModel extends BaseViewModel {

  // ThemeModel(this.context);
  BuildContext _context;

  // TODO: implement getter properly
  bool get isDarkTheme => locator<IStorageUtil>().getBool('IS_DARK_THEME') ?? /*(MediaQuery.of(_context).platformBrightness == Brightness.dark)*/ false;

  ThemeData theme([BuildContext context]) {
    _context = context;
    return isDarkTheme ? _theme.darkMaterialTheme : _theme.primaryMaterialTheme;
  }
  Future<void> setTheme() async {
    var newTheme = !isDarkTheme;
    await locator<IStorageUtil>().saveBool('IS_DARK_THEME', newTheme);
    notifyListeners();
    print('Notified listeners. Dark theme is: $isDarkTheme');
  }
}
