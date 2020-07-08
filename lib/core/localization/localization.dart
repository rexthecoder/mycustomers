import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'app_localization.dart';


class AppLocalizations{
  Map<String, String> localizedValues;
  AppLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  static AppLocalizations of(context){
    return Localizations.of<AppLocalizations>(context,AppLocalizations);
  }

  Future<bool> loadJsonFromAsset()async{
    String jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
    Map<String,dynamic> jsonLanguageMap = jsonDecode(jsonString);
    localizedValues = jsonLanguageMap.map((key, value) => MapEntry(key,value.toString()));
    return true;
  }

  String translate(String jsonKey){
    return localizedValues[jsonKey];
  }

  String get getStarted =>'jskx';




}

void stuff(){
  AppLocalization().signOut;
}
/*
LocalizationsDelegate localizationsDelegate= [
  ApplicationLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,

];*/
