import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends ReactiveViewModel {

  final _logService = locator<LogsLocalDataSourceImpl>();

  List<LogH> get loglist => _logService.loglist;
  bool get notify => _logService.shouldnotify;

  void getlogs(){
    _logService.getLogs();
    if(notify){
      _logService.setnotify();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logService];
}