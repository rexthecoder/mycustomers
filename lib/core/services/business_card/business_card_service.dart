import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';

abstract class BusinessCardService {

  Future<void> saveBusinessCard(BusinessCardH businessCard);

  Future<void> getBusinessCard();
}