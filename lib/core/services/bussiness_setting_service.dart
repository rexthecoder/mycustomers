import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycustomers/core/utils/user_settings_prefs.dart';

@lazySingleton
class BussinessSettingService with ReactiveServiceMixin{
  // Getting an instance of the shared preference helper class
  SharedPreferencesHelper sphObject = SharedPreferencesHelper();

  RxValue<int> _currency = RxValue<int>(initial: 0);
  RxValue<int> _language = RxValue<int>(initial: 0);
  List langs = [
    { 'name': 'English', 'selected': true },
    { 'name': 'Francias', 'selected': false },
  ];
  List currencies = [
    { 'name': 'Naira(NGN)', 'selected': true },
    { 'name': 'Dollar(USD)', 'selected': false },
    { 'name': 'Indian Rubies(INR)', 'selected': false },
  ];

  int get currency => _currency.value;
  int get language => _language.value;

  BussinessSettingService(){
    listenToReactiveValues([_currency, _language, langs, currencies]);
  }

  void selectLangs(int ind){
    langs[language]['selected'] = !langs[language]['selected'];
    langs[ind]['selected'] = !langs[ind]['selected'];
  }

  void selectCurrency(int ind) {
    currencies[currency]['selected'] = !currencies[currency]['selected'];
    currencies[ind]['selected'] = !currencies[ind]['selected'];
  }

  void setCurrencyIndex(int ind){
    _currency.value = ind;
  }

  void setLanguageIndex(int ind){
    _language.value = ind;
  }

  // Setters 
   void setNotification(bool value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     sphObject.setAllowsNotifications(value, prefs);
   
  }

  void setNewsletter(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sphObject.setAllowsNewsletter(value, prefs);
  
  }

  void setSpecial(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sphObject.setAllowsSpecialOffers(value, prefs);
  }

  void setUpdate(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sphObject.setAllowsUpdates(value, prefs);
  
  }

  void setTheme(bool value)  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sphObject.setAllowsLightMode(value, prefs);
   }

   // getters of the set preferences

   getSetNotification() async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     return await sphObject.getAllowsNotifications(pref);
   
  }

   getSetNewsletter() async{
  
  }

   getSetSpecial() async {
    
  }

   getSetUpdate() async{
  
  }

   getSetTheme() async {
   
  }

}