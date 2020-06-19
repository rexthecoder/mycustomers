import 'dart:ui';

import 'package:mycustomers/core/data_sources/onboarding_data.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewModel extends BaseViewModel {

  Color _color = onboardData[0].accentColor;

  Color get color => _color;

  set color(Color color) {
    _color = color;
    notifyListeners();
  }
}