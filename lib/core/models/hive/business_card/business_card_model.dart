import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'business_card_model.freezed.dart';

part 'business_card_model.g.dart';

@freezed
abstract class BusinessCard with _$BusinessCard {
  @HiveType(typeId: 0, adapterName: 'BusinessCardAdapter')
  const factory BusinessCard({
    @HiveField(0) @required String storeName,
    @HiveField(1) @required String personalName,
    @HiveField(2) @required String phoneNumber,
    @HiveField(3) @required String emailAddress,
    @HiveField(4) @required String address,
    @HiveField(5) @required String tagLine,
    @HiveField(6) @required String position,
    @HiveField(7) @required String cardDesign,
  }) = _BusinessCard;

  factory BusinessCard.empty() => BusinessCard(
        storeName: "Store Name",
        personalName: "Personal Name",
        phoneNumber: "+2348012345678",
        emailAddress: "Your Email",
        address: "Your Address",
        position: "Your Position",
        tagLine: "Company tag line",
        cardDesign: '0',
      );
}

//extension BusinessCardX on BusinessCard {
//  bool isEmpty() {
//    if (storeName.isEmpty ||
//        personalName.isEmpty ||
//        phoneNumber.isEmpty ||
//        emailAddress.isEmpty ||
//        address.isEmpty) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//}
