import 'package:hive/hive.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/business_card_model.dart';

abstract class IBusinessCardService {
  // to add a businessCard
  Future<void> saveBusinessCard(BusinessCard businessCard);

  // to get businessCards of a particular owner
  void getBusinessCard();
}

class BusinessCardService implements IBusinessCardService {
  final String key = 'business_card';

  @override
  Future<void> saveBusinessCard(BusinessCard businessCard) async {
    final businessCardBox = await Hive.openBox(HiveBox.businessCardBoxName);
    businessCardBox.put(key, businessCard);
    return Future.value();
  }

  @override
  Future<BusinessCard> getBusinessCard() async {
    final businessCardBox = await Hive.openBox(HiveBox.businessCardBoxName);
    final BusinessCard businessCard = businessCardBox.get(key) as BusinessCard;
    if (businessCard == null) {
      return Future.value(BusinessCard.empty());
    } else {
      return Future.value(businessCard);
    }
  }
}
