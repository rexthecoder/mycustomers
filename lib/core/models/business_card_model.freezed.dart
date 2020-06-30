// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'business_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BusinessCardTearOff {
  const _$BusinessCardTearOff();

  _BusinessCard call(
      {@required String storeName,
      @required String personalName,
      @required String phoneNumber,
      @required String emailAddress,
      @required String address}) {
    return _BusinessCard(
      storeName: storeName,
      personalName: personalName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      address: address,
    );
  }
}

// ignore: unused_element
const $BusinessCard = _$BusinessCardTearOff();

mixin _$BusinessCard {
  String get storeName;
  String get personalName;
  String get phoneNumber;
  String get emailAddress;
  String get address;

  $BusinessCardCopyWith<BusinessCard> get copyWith;
}

abstract class $BusinessCardCopyWith<$Res> {
  factory $BusinessCardCopyWith(
          BusinessCard value, $Res Function(BusinessCard) then) =
      _$BusinessCardCopyWithImpl<$Res>;
  $Res call(
      {String storeName,
      String personalName,
      String phoneNumber,
      String emailAddress,
      String address});
}

class _$BusinessCardCopyWithImpl<$Res> implements $BusinessCardCopyWith<$Res> {
  _$BusinessCardCopyWithImpl(this._value, this._then);

  final BusinessCard _value;
  // ignore: unused_field
  final $Res Function(BusinessCard) _then;

  @override
  $Res call({
    Object storeName = freezed,
    Object personalName = freezed,
    Object phoneNumber = freezed,
    Object emailAddress = freezed,
    Object address = freezed,
  }) {
    return _then(_value.copyWith(
      storeName: storeName == freezed ? _value.storeName : storeName as String,
      personalName: personalName == freezed
          ? _value.personalName
          : personalName as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress as String,
      address: address == freezed ? _value.address : address as String,
    ));
  }
}

abstract class _$BusinessCardCopyWith<$Res>
    implements $BusinessCardCopyWith<$Res> {
  factory _$BusinessCardCopyWith(
          _BusinessCard value, $Res Function(_BusinessCard) then) =
      __$BusinessCardCopyWithImpl<$Res>;
  @override
  $Res call(
      {String storeName,
      String personalName,
      String phoneNumber,
      String emailAddress,
      String address});
}

class __$BusinessCardCopyWithImpl<$Res> extends _$BusinessCardCopyWithImpl<$Res>
    implements _$BusinessCardCopyWith<$Res> {
  __$BusinessCardCopyWithImpl(
      _BusinessCard _value, $Res Function(_BusinessCard) _then)
      : super(_value, (v) => _then(v as _BusinessCard));

  @override
  _BusinessCard get _value => super._value as _BusinessCard;

  @override
  $Res call({
    Object storeName = freezed,
    Object personalName = freezed,
    Object phoneNumber = freezed,
    Object emailAddress = freezed,
    Object address = freezed,
  }) {
    return _then(_BusinessCard(
      storeName: storeName == freezed ? _value.storeName : storeName as String,
      personalName: personalName == freezed
          ? _value.personalName
          : personalName as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress as String,
      address: address == freezed ? _value.address : address as String,
    ));
  }
}

class _$_BusinessCard implements _BusinessCard {
  const _$_BusinessCard(
      {@required this.storeName,
      @required this.personalName,
      @required this.phoneNumber,
      @required this.emailAddress,
      @required this.address})
      : assert(storeName != null),
        assert(personalName != null),
        assert(phoneNumber != null),
        assert(emailAddress != null),
        assert(address != null);

  @override
  final String storeName;
  @override
  final String personalName;
  @override
  final String phoneNumber;
  @override
  final String emailAddress;
  @override
  final String address;

  @override
  String toString() {
    return 'BusinessCard(storeName: $storeName, personalName: $personalName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessCard &&
            (identical(other.storeName, storeName) ||
                const DeepCollectionEquality()
                    .equals(other.storeName, storeName)) &&
            (identical(other.personalName, personalName) ||
                const DeepCollectionEquality()
                    .equals(other.personalName, personalName)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.emailAddress, emailAddress) ||
                const DeepCollectionEquality()
                    .equals(other.emailAddress, emailAddress)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(storeName) ^
      const DeepCollectionEquality().hash(personalName) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(emailAddress) ^
      const DeepCollectionEquality().hash(address);

  @override
  _$BusinessCardCopyWith<_BusinessCard> get copyWith =>
      __$BusinessCardCopyWithImpl<_BusinessCard>(this, _$identity);
}

abstract class _BusinessCard implements BusinessCard {
  const factory _BusinessCard(
      {@required String storeName,
      @required String personalName,
      @required String phoneNumber,
      @required String emailAddress,
      @required String address}) = _$_BusinessCard;

  @override
  String get storeName;
  @override
  String get personalName;
  @override
  String get phoneNumber;
  @override
  String get emailAddress;
  @override
  String get address;
  @override
  _$BusinessCardCopyWith<_BusinessCard> get copyWith;
}
