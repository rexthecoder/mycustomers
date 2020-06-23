import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_card_model.freezed.dart';

@freezed
abstract class BusinessCard with _$BusinessCard {
  const factory BusinessCard({
    @required String storeName,
    @required String personalName,
    @required String phoneNumber,
    @required String emailAddress,
    @required String address,
  }) = _BusinessCard;

  factory BusinessCard.empty() => BusinessCard(
      storeName: "Store Name",
      personalName: "John Doe",
      phoneNumber: "+2348012345678",
      emailAddress: "johndoe@mycustomer.com",
      address: "We are all over the earth");
}
