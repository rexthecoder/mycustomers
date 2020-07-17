import 'package:hive/hive.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';

abstract class BusinessCardLocalDataSource {
  Future<BusinessCardH> getBusinessCardH(String id);

  Future<BusinessCardH> updateBusinessCardH(
      String id, BusinessCardH businessCard);

  Future<void> createBusinessCardH(String id, BusinessCardH businessCard);

  Future<void> deleteBusinessCardH(String id);
}

class BusinessCardLocalDataSourceImpl implements BusinessCardLocalDataSource {
  final String key = 'business_card';

  @override
  Future<BusinessCardH> getBusinessCardH(String id) async {
    final businessCardBox =
        await Hive.openBox<BusinessCardH>(HiveBox.businessCardBoxName);
    final BusinessCardH businessCard = businessCardBox.get(key);
    return Future.value(businessCard);
  }

  @override
  Future<void> createBusinessCardH(String id, newBusinessCardH) async {
    final businessCardBox = await Hive.openBox(HiveBox.businessCardBoxName);
    businessCardBox.put(key, newBusinessCardH);
    return Future.value();
  }

  @override
  Future<void> deleteBusinessCardH(String id) {
    // TODO: implement deleteBusinessCardH
    throw UnimplementedError();
  }

  @override
  Future<BusinessCardH> updateBusinessCardH(
      String id, BusinessCardH businessCard) {
    // TODO: implement updateBusinessCardH
    throw UnimplementedError();
  }
}
