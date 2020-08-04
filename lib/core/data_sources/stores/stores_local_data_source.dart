import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/hive/user_profile/profile_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/models/hive/store/store_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/profile_service.dart';
import 'package:mycustomers/core/enums/connectivity_status.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:mycustomers/core/services/api_services.dart';

abstract class StoresLocalDataSource {
  Future<void> init();

  Store getStore(String id);

  Iterable<Store> getStores();

  Iterable<Store> getStoresWhere(bool Function(StoreH) test);

  Future<Store> updateStore(String id, Store update);

  Future<bool> createStore(Store newStore, [String id]);

  Future<bool> deleteStore(String id);

  Future<void> syncStores(ConnectivityStatus connectionStatus);

  Stream<bool> get reloadStream;
}

class StoresLocalDataSourceImpl implements StoresLocalDataSource {
  StoresLocalDataSourceImpl() {
    init();
  }
  static const STORE_HIVE_BOX_NAME = 'STORE';

  final _hiveService = locator<HiveInterface>();
  final _auth = locator<AuthService>();
  final _profileService = locator<ProfileService>();
  final IApi _api = locator<IApi>();

  static Box<StoreH> storeBox;

  final StreamController<bool> _reloadStreamController =
      StreamController<bool>.broadcast();

  @override
  Stream<bool> get reloadStream =>
      _reloadStreamController.stream.asBroadcastStream();

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
    await _hiveService.openBox<StoreH>(STORE_HIVE_BOX_NAME);
    storeBox = _hiveService.box<StoreH>(STORE_HIVE_BOX_NAME);
  }

  String genUuid() {
    return Uuid().v1();
  }

  //
  // Read Operations
  //

  @override
  Store getStore(String id) {
    var store = storeBox.get(id);
    return Store.fromStoreH(store);
  }

  @override
  Iterable<Store> getStores() {
    return storeBox.values
        .where((element) => element.ownerId == _auth.currentUser?.id)
        .map((e) => Store.fromStoreH(e));
  }

  @override
  Iterable<Store> getStoresWhere(bool Function(StoreH p1) test) {
    return storeBox.values
        .where((element) {
          print('${element.ownerId} Dirty state is: ${element.isDirty}');
          return element.ownerId == _auth.currentUser?.id;
        })
        .where(test)
        .map((e) => Store.fromStoreH(e));
  }

  List<int> splitPhone(String phone) {
    try {
      var pNum = phone.substring(phone.length - 10);
      var ctyCode = phone.substring(0, phone.length - 10);
      return [int.parse(pNum), int.parse(ctyCode)];
    } catch (e) {
      return [null, null];
    }
  }

  //
  // Create operation
  //

  @override
  Future<bool> createStore(Store newStore, [String id]) async {
    try {
      var response = await _api.newStore(
          newStore.name, newStore.address, newStore.tagline,
          email: newStore.email, phoneNumer: newStore.phone);
      // Convert the returned response to a store object
      Store apiStore = Store.fromJson(response['data']['store']);
      var newStoreH = apiStore.toStoreH();
      await storeBox.put(newStoreH.id, newStoreH);
      await StoreRepository.updateStores();
      StoreRepository.changeSelectedStore(newStoreH.id);
    } catch (e) {
      print(newStore.phone);
      var splitP = splitPhone(newStore.phone);
      var newStoreH = StoreH(
        id ?? genUuid(),
        newStore.address,
        newStore.name,
        splitP[0],
        splitP[1],
        newStore.tagline,
        _auth.currentUser.id,
        newStore.email,
        newStore.storePic,
      )..lastUpdated = DateTime.now()..isDirty = true;
      await storeBox.put(newStoreH.id, newStoreH);
      await StoreRepository.updateStores();
      StoreRepository.changeSelectedStore(newStoreH.id);
      Profile profile = new Profile(
          name: _auth.currentUser?.firstName ?? 'None',
          image: '',
          sId: newStoreH.id);
      _profileService.addProfile(profile);
    }
    return true;
  }

  //
  // Update Operations
  //

  @override
  Future<Store> updateStore(String id, Store update) async {
    try {
      var response = await _api.updateStoreDetails(id, _auth.currentUser.id,
          address: update.address, name: update.name);
      Store newStore = Store.fromJson(response['data']['store']);
      var updatedStore = newStore.toStoreH();
      await storeBox.put(updatedStore.id, updatedStore);
      return Store.fromStoreH(updatedStore); // Seems unneccesary
    } catch (e) {
      var splitP = splitPhone(update.phone);
      var sToUpdate = storeBox.get(id);
      var updatedStore = StoreH(
        id,
        update.address ?? sToUpdate.address,
        update.name ?? sToUpdate.name,
        splitP[0] ?? sToUpdate.pNum,
        splitP[1] ?? sToUpdate.ctyCode,
        update.tagline ?? sToUpdate.tagline,
        sToUpdate.ownerId,
        sToUpdate.email,
        update.storePic ?? sToUpdate.storePic,
      )..lastUpdated = DateTime.now()..isDirty = true;
      await storeBox.put(updatedStore.id, updatedStore);
      return Store.fromStoreH(updatedStore);
    }
  }

  @override
  Future<bool> deleteStore(String id) async {
    try {
      try {
        await _api.deleteStore(id);
      } catch (e) {
        var toDelete = storeBox.get(id)..deleted = true;
        await storeBox.put(id, toDelete);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Store compareAndUpdate(Store store1, Store store2) {
    return store1.compare(store2);
  }

  @override
  Future<void> syncStores(ConnectivityStatus connectionStatus) async {
    // Check if the connection status is a valid type we can use
    if (connectionStatus == ConnectivityStatus.WiFi ||
        connectionStatus == ConnectivityStatus.Cellular) {
      try {
        // Fetch all stores from the API
        var response = await _api.getAllStores();
        // Convert the response into a list of our store obbjects
        Iterable<Store> stores = response['data']['stores']
            .map<Store>((store) => Store.fromJson(store));
        // Loop through the stores and perform neccesary updates
        for (Store store in stores) {
          // Check if we already have a version of the current store locally
          if (storeBox.containsKey(store.id)) {
            // Compare the 2 versions and get the latest
            Store update = compareAndUpdate(store, getStore(store.id));
            // if they're different, save the correct version. Do nothing otherwise
            if (update != null) {
              await updateStore(update.id, update);
            }
          } else {
            // If we don't already have a version of the store
            // Split the phone number so we can save locally
            var splitP = splitPhone(store.phone);
            // Create the new store oject to save
            var newStoreH = StoreH(
              store.id ?? genUuid(),
              store.address,
              store.name,
              splitP[0],
              splitP[1],
              store.tagline,
              _auth.currentUser.id,
              store.email,
              store.storePic,
            );
            // Save the new object with the ID got from the API
            await storeBox.put(newStoreH.id, newStoreH);
          }
        }

        //
        // Send stores that haven't got to the remote DB
        //

        // Get all stores on our database that haven't got to the remote DB (Dirty stores)
        Iterable<Store> dirtyStores =
            getStoresWhere((p1) => p1.isDirty).toList();
        print(dirtyStores);
        // Loop through the dirty stores
        for (Store dirtyStore in dirtyStores) {
          // If the store has been deleted locally, delete it online too
          if (dirtyStore.deleted) {
            await _api.deleteStore(dirtyStore.id);
            // Delete the deleted store since we don't need it again
            await storeBox.delete(dirtyStore.id);
          } else {
            // If it hasn't been deleted, send it to the API

            // Send request to create new store
            var response = await _api.newStore(
                dirtyStore.name, dirtyStore.address, dirtyStore.tagline,
                email: dirtyStore.email, phoneNumer: dirtyStore.phone);
            // Convert the returned response to a store object
            Store newStore = Store.fromJson(response['data']['store']);
            // Save the new store with the new ID locally
            await storeBox.put(newStore.id, newStore.toStoreH());
            // Delete the old store with locally generated ID
            await storeBox.delete(dirtyStore.id);
          }
        }
      } catch (e, s) {
        Logger.e('Store sync\nException: $e\nStacktrace\n$s', e: e, s: s);
      }
      // Refresh our local store Repo so the app receives the updates
      await StoreRepository.updateStores();
      _reloadStreamController.add(true);
    }
  }

  //
  // Delete ops
  //

}
