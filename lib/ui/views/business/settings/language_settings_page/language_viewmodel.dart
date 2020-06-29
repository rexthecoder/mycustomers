import 'package:stacked/stacked.dart';

class LanguageSettingsViewModel extends BaseViewModel{
  List<Languages> languages = [
    Languages(language: 'English',index: 0),
    Languages(language: 'Francias',index: 1),
    Languages(language: 'Espanyol',index: 2),
    Languages(language: 'German',index: 3),
  ];

  int currentIndex = 0;

  Function languageBoxColorChanger(model,language){
    currentIndex = languages.indexOf(language);
    return null;
  }
  ///notifyListener didn't work here sadly

}

class Languages {
  final String language;
  final String imagePath;
  final int index;

  Languages({this.language, this.imagePath,this.index});
}