import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class PageService with ReactiveServiceMixin {
  RxValue<int> _page = RxValue<int>(initial: 0);
  int get page => _page.value;

  PageService() {
    listenToReactiveValues([_page]);
  }

  void updatePage() {
    _page.value = _page.value == 0 ? 1 : 0;
  }
}