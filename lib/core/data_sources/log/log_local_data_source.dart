import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/utils/file_helper.dart';

abstract class LogsLocalDataSource {
  /// Initialize Hive DB
  Future<void> init();

  /// Saves all the log [values] with auto-increment keys.
  Future<void> addLog(LogH log);

  /// Deletes the n-th key from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> deleteLog(int id);



   void getValues(String date, int price, DateTime time, String action, String name){

    int totallogs = _logsBox.values.toList().length; 
    String msg = action == 'credit' ? 'You made a credit for $name' : 'You made a debit for $name';
    LogH newlog = new LogH(totallogs+1, msg, action, time);

  }




 
}

class LogsLocalDataSourceImpl implements LogsLocalDataSource {
  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.logs);
  Box<LogH> get _logsBox => _hiveService.box<LogH>(HiveBox.logs);

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<LogH>(LogHAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<LogH>(HiveBox.logs);
    }
  }

  @override
  Future<void> addLog(LogH log) async {
    return _logsBox.put(log.id, log);
  }

  @override
  Future<void> deleteLog(int id) async {
    return _logsBox.delete(id);
  }
}
