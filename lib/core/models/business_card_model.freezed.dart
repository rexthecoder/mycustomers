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
      {@required @HiveField(0) String storeName,
      @required @HiveField(1) String personalName,
      @required @HiveField(2) String phoneNumber,
      @required @HiveField(3) String emailAddress,
      @required @HiveField(4) String address}) {
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
  @HiveField(0)
  String get storeName;
  @HiveField(1)
  String get personalName;
  @HiveField(2)
  String get phoneNumber;
  @HiveField(3)
  String get emailAddress;
  @HiveField(4)
  String get address;

  $BusinessCardCopyWith<BusinessCard> get copyWith;
}

abstract class $BusinessCardCopyWith<$Res> {
  factory $BusinessCardCopyWith(
          BusinessCard value, $Res Function(BusinessCard) then) =
      _$BusinessCardCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String storeName,
      @HiveField(1) String personalName,
      @HiveField(2) String phoneNumber,
      @HiveField(3) String emailAddress,
      @HiveField(4) String address});
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
      {@HiveField(0) String storeName,
      @HiveField(1) String personalName,
      @HiveField(2) String phoneNumber,
      @HiveField(3) String emailAddress,
      @HiveField(4) String address});
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

@HiveType(typeId: 0, adapterName: 'BusinessCardAdapter')
class _$_BusinessCard implements _BusinessCard {
  const _$_BusinessCard(
      {@required @HiveField(0) this.storeName,
      @required @HiveField(1) this.personalName,
      @required @HiveField(2) this.phoneNumber,
      @required @HiveField(3) this.emailAddress,
      @required @HiveField(4) this.address})
      : assert(storeName != null),
        assert(personalName != null),
        assert(phoneNumber != null),
        assert(emailAddress != null),
        assert(address != null);

  @override
  @HiveField(0)
  final String storeName;
  @override
  @HiveField(1)
  final String personalName;
  @override
  @HiveField(2)
  final String phoneNumber;
  @override
  @HiveField(3)
  final String emailAddress;
  @override
  @HiveField(4)
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
      {@required @HiveField(0) String storeName,
      @required @HiveField(1) String personalName,
      @required @HiveField(2) String phoneNumber,
      @required @HiveField(3) String emailAddress,
      @required @HiveField(4) String address}) = _$_BusinessCard;

  @override
  @HiveField(0)
  String get storeName;
  @override
  @HiveField(1)
  String get personalName;
  @override
  @HiveField(2)
  String get phoneNumber;
  @override
  @HiveField(3)
  String get emailAddress;
  @override
  @HiveField(4)
  String get address;
  @override
  _$BusinessCardCopyWith<_BusinessCard> get copyWith;
}
