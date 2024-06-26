import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static late SharedPreferences prefs;
  static const String NewTokenValue = "newTokenValue1";
  static const String UserName = "USERNAME";
  static const String UserLastName = "USERLASTNAME";
  static const String EmailID = "EMAILID";
  static const String SetProfileURl = "SETPROFILEURL";

// // SET LOGIN TOKEN

  static Future<bool> setTokenKey(String tokenKey1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(NewTokenValue, tokenKey1);
  }

// // SET User name

  static Future<bool> setUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(UserName, userName);
  }
// // SET User Last name

  static Future<bool> setUserLastName(String userLastName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(UserLastName, userLastName);
  }

  // // SET User email
  static Future<bool> setEmail(String Email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(EmailID, Email);
  }

  // SEt profile Url
  static Future<bool> setProfileUrl(String ProfileUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(SetProfileURl, ProfileUrl);
  }
// GET LOGIN TOKEN

  static Future<String?> getTokenKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(NewTokenValue);
  }

  // Get User Name
  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(UserName);
  }

  // Get User Name
  static Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(EmailID);
  }

  // Get User Name
  static Future<String?> getProfileURL() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(SetProfileURl);
  }

  // Get User Name
  static Future<String?> getUserLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(UserLastName);
  }
}
