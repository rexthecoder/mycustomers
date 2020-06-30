// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    id: json['id'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    tagline: json['tagline'] as String,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'tagline': instance.tagline,
    };
