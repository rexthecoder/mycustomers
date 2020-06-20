import 'package:shared_preferences/shared_preferences.dart';

abstract class IStorageUtil {

  bool getBool(String key, {def: false});

  Future<void> saveBool(String key, bool value);

  String getString(String key, {def: ''});

  Future<void> saveString(String key, String value);

  int getInt(String key, {def: 0});

  Future<void> saveInt(String key, int value);

  double getDouble(String key, {def: 0.0});

  Future<void> saveDouble(String key, double value);

  List<String> getListOfStrings(String key, {def: const []});

  Future<void> saveListOfStrings(String key, List<String> value);

}

class SharedStorageUtil implements IStorageUtil {

  SharedPreferences _preferences;
  static SharedStorageUtil _storage;

  static Future<SharedStorageUtil> getInstance() async {
    if (_storage == null) {
      SharedStorageUtil placeHolder = SharedStorageUtil._();
      placeHolder.init();
      _storage = placeHolder;
    }

    return _storage;
  }

  Future<void> init() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  SharedStorageUtil._();

  @override
  bool getBool(String key, {def: false}) {
    return _preferences.getBool(key) ?? def;
  }

  @override
  int getInt(String key, {def: 0}) {
    return _preferences.getInt(key) ?? def;
  }

  @override
  String getString(String key, {def: ''}) {
    return _preferences.getString(key) ?? def;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  @override
  double getDouble(String key, {def = 0.0}) {
    return _preferences.getDouble(key) ?? def;
  }

  @override
  List<String> getListOfStrings(String key, {def = const []}) {
    return _preferences.getStringList(key) ?? def;
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  @override
  Future<void> saveListOfStrings(String key, List value) async {
    await _preferences.setStringList(key, value);
  }

}
