import 'package:stacked/stacked.dart';

class StuffModel extends BaseViewModel{
  String _upperBoxText = 'Happy New Year!';
  String get upperBoxText =>_upperBoxText;

  String lowerBoxText = 'Happy New Year \n Best wishes from me';

  List<String> templateList = [
    'Happy New Year \n Best wishes from me',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Reloaded 3 of 692 libraries in 1,777ms.',
    'Reloaded 3 of 692 libraries in 1,777ms.'
  ];

  int numberOfSelectedCustomers = 3;

  bool checkBoxValue = true;
  checkBoxFunction(bool val){
    checkBoxValue = val;
    val = !val;

  }

  int currentIndex = 0;
  onTap(template){
    currentIndex = templateList.indexOf(template);
  }
}