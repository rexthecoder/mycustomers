import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/stores/stores_remote_data_source.dart';
import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class StoreRepository {
  static List _stores;
  static StoresLocalDataSource _ss = locator<StoresLocalDataSource>();
  static DialogService _dialog = locator<DialogService>();
  static Store _currentStore;

  static List<Store> get stores => _stores;
  static Store get currentStore => _currentStore;

  static changeSelectedStore(String id) {
    var newStore = _stores.firstWhere((elem) => elem.id == id, orElse: () => null);
    _currentStore = newStore ?? _currentStore;
  }

  static Future<void> updateStores() async {
    try {

    var stores = (await _ss.getStores()).toList();
    _stores = stores ?? _stores;
    if (_stores != null && _stores.isNotEmpty) _currentStore = _stores[0];
    print('Stores is now: $_stores and current store is $_currentStore');
    } catch(e, s) {
      Logger.e('Refresh store list Error\nException: $e\nStacktrace: $s', e: e, s: s);
      rethrow;
    }
    
  }

  static Future<Store> getStoreById(String id) async {
    try {
      return _stores.firstWhere((store) => store.id == id);
    } on StateError {
      var store = await _ss.getStore(id);
      return store;
    }
  }

  static Future<bool> deleteCurrentStore() async {
    var response = await _dialog.showConfirmationDialog(
      title: 'Confirm',
      description: 'Are you sure you want to delete this store? There\'s no going back.',
      confirmationTitle: 'Yes, I\'m sure',
      cancelTitle: "No, I'm not sure",
      );
    if (response.confirmed) {
      // TODO: Add delete function
    }
    return false;
  }



}