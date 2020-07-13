import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';

abstract class StoresLocalDataSource {
  Future<void> init();
}

class StoresLocalDataSourceImpl implements StoresLocalDataSource {
  final _hiveService = locator<HiveInterface>();

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
  }
}
