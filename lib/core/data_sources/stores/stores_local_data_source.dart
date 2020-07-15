import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/models/hive/store/store_h.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:uuid/uuid.dart';

abstract class StoresLocalDataSource {
  Future<void> init();

  Future<Store> getStore(String id);

  Future<Iterable<Store>> getAllStores();

  Future<Iterable<Store>> getStoresWhere(Function(StoreH) test);

  Future<Store> updateStore(String id, Store update);

  Future<bool> createStore(Store newStore);

  Future<bool> deleteStore(String id);
}

class StoresLocalDataSourceImpl implements StoresLocalDataSource {
  // final _hiveService = locator<HiveInterface>();
  final _auth = locator<AuthService>();

  final storeBox = Hive.box<StoreH>('STORE');

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
  }

  String genUuid() {
    return Uuid().v1();
  }


  //
  // Read Operations
  //

  @override
  Future<Store> getStore(String id) async {
    var store = storeBox.get(id);
    return Store.fromStoreH(store);
  }

  @override
  Future<Iterable<Store>> getAllStores() async {
    return storeBox.values.map((e) => Store.fromStoreH(e));
  }

  @override
  Future<Iterable<Store>> getStoresWhere(Function(StoreH p1) test) async {
    return storeBox.values.where(test).map((e) => Store.fromStoreH(e));
  }

  List<int> splitPhone(String phone) {
    var pNum = phone.substring(phone.length - 10);
    var ctyCode = phone.substring(0, phone.length - 10);
    try {
      return [int.parse(pNum), int.parse(ctyCode)];
    } catch (e) {
      return [null, null];
    }
  }

  //
  // Create operation
  //

  @override
  Future<bool> createStore(Store newStore) async {
    var splitP = splitPhone(newStore.phone);
    var newStoreH = StoreH(genUuid(), newStore.address, newStore.name, splitP[0], splitP[1], newStore.tagline, _auth.currentUser.id);
    storeBox.put(newStoreH.id, newStoreH);
    return true;
  }




  //
  // Update Operations
  //

  @override
  Future<Store> updateStore(String id, Store update) async {
    var splitP = splitPhone(update.phone);
    var sToUpdate = storeBox.get(id);
    var updatedStore = StoreH(
      id,
      update.address ?? sToUpdate.address,
      update.name ?? sToUpdate.name,
      splitP[0] ?? sToUpdate.pNum,
      splitP[1] ?? sToUpdate.ctyCode,
      update.tagline ?? sToUpdate.tagline,
      sToUpdate.ownerId
      );
    storeBox.put(updatedStore.id, updatedStore);
    return Store.fromStoreH(updatedStore);
  }

  @override
  Future<bool> deleteStore(String id) async {
    try {
      storeBox.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }



  //
  // Delete ops
  //





}