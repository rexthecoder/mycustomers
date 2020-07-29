import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository.dart';
import 'package:mycustomers/core/services/business_card/business_card_service.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class BusinessCardServiceImpl
    with ReactiveServiceMixin
    implements BusinessCardService {
  final BusinessCardRepository businessCardRepository;

  RxValue<BusinessCardH> _businessCard = RxValue<BusinessCardH>(
    initial: BusinessCardH.empty(),
  );

  BusinessCardServiceImpl({this.businessCardRepository}) {
    listenToReactiveValues([_businessCard]);
  }

  BusinessCardH get businessCard => _businessCard.value;

  @override
  Future<void> getBusinessCard() async {
    _businessCard.value = await businessCardRepository.getBusinessCard();
  }

  @override
  Future<void> saveBusinessCard(BusinessCardH businessCard) async {
    await businessCardRepository.saveBusinessCard(businessCard);
    _businessCard.value = businessCard;
  }
}
