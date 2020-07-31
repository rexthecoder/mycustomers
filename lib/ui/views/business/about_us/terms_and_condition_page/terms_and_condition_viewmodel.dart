import 'package:stacked/stacked.dart';

class TermsAndConditionViewModel extends BaseViewModel {
  bool _terms = false;
  bool get terms => _terms;

  bool _license = false;
  bool get license => _license;

  bool _disclaimer = false;
  bool get disclaimer => _disclaimer;

  bool _limitations = false;
  bool get limitations => _limitations;

  bool _accuracy = false;
  bool get accuracy => _accuracy;

  bool _links = false;
  bool get links => _links;

  bool _modifications = false;
  bool get modifications => _modifications;

  bool _law = false;
  bool get law => _law;

  void setTerms() {
    _terms = !_terms;
    notifyListeners();
  }

  void setLicense() {
    _license = !_license;
    notifyListeners();
  }

  void setDisclaimer() {
    _disclaimer = !_disclaimer;
    notifyListeners();
  }

  void setLimitations() {
    _limitations = !_limitations;
    notifyListeners();
  }

  void setAccuracy() {
    _accuracy = !_accuracy;
    notifyListeners();
  }

  void setLinks() {
    _links = !_links;
    notifyListeners();
  }

  void setModifications() {
    _modifications = !_modifications;
    notifyListeners();
  }

  void setLaw() {
    _law = !_law;
    notifyListeners();
  }

  String text = '';
}
