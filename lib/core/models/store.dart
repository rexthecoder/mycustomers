import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'hive/store/store_h.dart';

part 'store.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class Store extends Equatable {
  @JsonKey(ignore: true)
  Uint8List storePic;

  Store(this.id, this.email, this.phone, this.tagline, this.address, {this.name, this.ownerId, this.storePic});

  @JsonKey(name: '_id')
  final String id;

  final String email, tagline;

  @JsonKey(name: 'phone_number')
  final String phone;

  @JsonKey(name: 'shop_address')
  final String address;

  @JsonKey(name: 'store_name')
  final String name;

  // TODO: Add json key
  @JsonKey(name: 'store_admin_ref', fromJson: ownerIdFromJson)
  String ownerId;

  @JsonKey(name: 'updatedAt', fromJson: dateFromJson, toJson: dateToJson)
  DateTime lastUpdated;

  @JsonKey(ignore: true)
  bool deleted;

  Store compare(Store otherStore) {
    if (otherStore == this) return null;
    if (otherStore?.lastUpdated?.compareTo(this.lastUpdated ?? DateTime.fromMillisecondsSinceEpoch(0)) ?? -1 > 0)
      return otherStore;
    else if (otherStore?.lastUpdated?.compareTo(this?.lastUpdated ?? DateTime.fromMillisecondsSinceEpoch(0)) ?? -1 < 0)
      return this;
    return null;
  }

  List<int> splitPhone() {
    try {
      var pNum = phone.substring(phone.length - 10);
      var ctyCode = phone.substring(0, phone.length - 10);
      return [int.parse(pNum), int.parse(ctyCode)];
    } catch (e) {
      return [null, null];
    }
  }

  factory Store.fromStoreH(StoreH store) => Store(
        store.id,
        store.email,
        store.ctyCode != null && store.pNum != null ?'+${store.ctyCode}${store.pNum}' : null,
        store.tagline,
        store.address,
        name: store.name,
        storePic: store.storePic
      )
        ..deleted = store.deleted;
  StoreH toStoreH() {
    var splitP = this.splitPhone();
    return StoreH(
      this.id,
      this.address,
      this.name,
      splitP[0],
      splitP[1],
      this.tagline,
      this.ownerId,
      this.email,
      this.storePic,
    );
  }

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);

  static DateTime dateFromJson(String formmattedDate) {
    try {
      return DateTime.tryParse(formmattedDate);
    } catch (e) {
      return null;
    }
  }

  static String dateToJson(DateTime date) {
    return date.toIso8601String();
  }

  static String ownerIdFromJson(userRef) {
    if (userRef != null) {
      try {
        print('First ref $userRef');
        return userRef as String;
      } catch (e) {
        print('User ref id is: ${userRef['_id']}');
        return userRef['_id'] as String;
      }
    }
    return null;
  }
  @override
  String toString() => this.id;

  @override
  // TODO: implement props
  List<Object> get props => [name, address, email, tagline, phone, ownerId, id];

  @override
  bool get stringify => true;
}
