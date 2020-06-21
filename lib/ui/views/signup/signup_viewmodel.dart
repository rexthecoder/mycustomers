import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/page_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends ReactiveViewModel{
  final _pageservice = locator<PageService>();
  int _page = 0;
  int get page => _pageservice.page;

  String _name;
  String get name => _name;

  String _company;
  String get company => _company;

  void updatePage() {
    _pageservice.updatePage();
    notifyListeners();
  }

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateCompany(String value) {
    _company = value;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pageservice];

}