import 'package:stacked/stacked.dart';

class  MarketingHomePageViewModel extends BaseViewModel {
    // dummy data
    // TODO: implement service to get frequently contacted
    List _persons = [
    {
      'name': 'Seyi Onifade',
      'number': '09088355273'
    },
    {
      'name': 'Mark Essien',
      'number': '09088355273'
    },
    {
      'name': 'Ufe Atabo',
      'number': '09088355273'
    }
  ];

  // TODO: implement service to get notification status
  bool _notification = true;

  bool get notification => _notification;

  List get persons => _persons;
}