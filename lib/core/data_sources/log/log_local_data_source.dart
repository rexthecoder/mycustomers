import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/utils/file_helper.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

abstract class LogsLocalDataSource {
  /// Initialize Hive DB
  Future<void> init();

  /// Saves all the log [values] with auto-increment keys.
  Future<void> addLog(LogH log);
  void getLogs();

  /// Deletes the n-th key from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> deleteLog(int id);

  void getValues(String date, int price, DateTime time, String action, String name);
}

class LogsLocalDataSourceImpl with ReactiveServiceMixin implements LogsLocalDataSource {
  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.logs);
  Box<LogH> get _logsBox => _hiveService.box<LogH>(HiveBox.logs);

  RxValue<List<LogH>> _loglist = RxValue<List<LogH>>(initial: []);
  List<LogH> get loglist => _loglist.value;

  bool shouldnotify = false;

  @override
  Future<void> init() async {
    //final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    //_hiveService.init(path);
    _hiveService.registerAdapter<LogH>(LogHAdapter());

    if (!_isBoxOpen) {
      await Hive.openBox<LogH>(HiveBox.logs);
    }
  }

  @override
  void getValues(String date, int price, DateTime time, String action, String name){

    int totallogs = _logsBox.values.toList().length; 
    String msg = action == 'credit' ? 'You made a credit for $name' : 'You made a debit for $name';
    LogH newlog = new LogH(totallogs+1, msg, action, time);
    addLog(newlog);
  }

  void testfunc(DateTime time){
    int totallogs = _logsBox.values.toList().length; 
    String msg = 'Welcome Login at'+time.toString();
    LogH newlog = new LogH(totallogs+1, msg, 'debit', time);
    print(newlog);
    addLog(newlog);
  }

  void setnotify(){
    shouldnotify = !shouldnotify;
  }

  @override
  Future<void> addLog(LogH log) async {
    return _logsBox.put(log.id, log).then((value) {
      if(!shouldnotify){
        setnotify();
      }
    });
  }

  @override
  Future<void> deleteLog(int id) async {
    return _logsBox.delete(id);
  }

  @override
  void getLogs() {
    _loglist.value = _logsBox.values.toList();
  }
}
