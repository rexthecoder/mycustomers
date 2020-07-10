import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/store_services.dart';
import 'package:mycustomers/core/models/store.dart';

class StoreRepository {
  static List _stores;
  static StoreService _ss = locator<StoreService>();

  static List<Store> get stores => _stores;

  static Future<void> updateStores() async {
    var stores = await _ss.getStores();
    _stores = stores ?? _stores;
    print('Stores is now: $_stores');
  }

  static Future<Store> getStoreById(String id) async {
    try {
      return _stores.firstWhere((store) => store.id == id);
    } on StateError {
      var store = await _ss.getStore(id);
      return store;
    }
  }



}