// This class will store the user  settings preferences.
//It will also help with persisiting the settings
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesHelper{
  static SharedPreferencesHelper _instance;

  factory SharedPreferencesHelper() => _instance ??= new SharedPreferencesHelper._();
  SharedPreferencesHelper._();

  ///
  /// Instantiation of the SharedPreferences library
  ///
  static String _kUserPin='userpin';
 
  

  /// ------------------------------------------------------------
  /// Methods that saves and returns the user encrypted password
  /// ------------------------------------------------------------
  Future<bool> saveUserPin(String pin,SharedPreferences pref) async{

    return  pref.setString(_kUserPin, pin);

  }
  Future<String>getUserPin(SharedPreferences pref)async{
   return pref.getString(_kUserPin);

 }

 Future<void>removeUserPin(SharedPreferences pref) async{
   pref.remove(_kUserPin);
 }

  

}