import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test_arun/Models/user_Login_Model.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:machine_test_arun/Models/user_detail_Model.dart';
import 'package:machine_test_arun/Screens/HomeScreen/home_Screen.dart';
import 'package:machine_test_arun/Screens/auth/login_Screen.dart';
import 'package:machine_test_arun/services/db.dart';
import 'package:machine_test_arun/services/server_Detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  static Future<void> logInRequest(
    String emailId,
    String password,
    BuildContext context,
  ) async {
    var request = {};
    request["password"] = password;
    request["email"] = emailId;
    try {
      var response = await http.post(
        Uri.parse(ServerDetails.logIn),
        body: convert.jsonEncode(request),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      String? userToken;
      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse["status"] == true &&
          jsonResponse["message"] == "Login successfully.") {
        Db.setTokenKey(jsonResponse["record"]["authtoken"].toString());
        Db.setUserName(jsonResponse["record"]["firstName"].toString());
        Db.setUserLastName(jsonResponse["record"]["lastName"].toString());
        Db.setEmail(jsonResponse["record"]["email"].toString());
        Db.setProfileUrl(jsonResponse["record"]["profileImg"].toString());

        await Db.getTokenKey().then((value) {
          userToken = value!;
        });
        log("sign up token ->${userToken} ");

        Fluttertoast.showToast(msg: "Login successfully.");

        log("token=>" + userToken.toString());

        final route =
            MaterialPageRoute(builder: (context) => const HomeScreen());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(msg: jsonResponse["message"].toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (error) {
      // Handle network errors, unsupported media type, and other exceptions here
      log('Error: $error');
      if (error is SocketException) {
        Fluttertoast.showToast(msg: "No internet connection");
      } else if (error is FormatException) {
        Fluttertoast.showToast(msg: "Unsupported media type");
      } else {
        Fluttertoast.showToast(msg: "An error occurred");
      }
    }
  }

  //sign up
  static Future<void> signUpRequest(
    String firstName,
    String lastName,
    String countrycode,
    String phoneNo,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    var request = {};

    request["first_name"] = firstName;
    request["last_name"] = lastName;
    request["country_code"] = "+$countrycode";
    request["phone_no"] = phoneNo;

    request["email"] = email;
    request["password"] = password;

    request["confirm_password"] = password;
    try {
      var response = await http.post(
        Uri.parse(ServerDetails.signUp),
        body: convert.jsonEncode(request),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      log("${response.body}");
      String? userToken;
      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse["status"] == true) {
        Db.setTokenKey(jsonResponse["data"]["token"].toString());
        Db.setEmail(jsonResponse["data"]["email"].toString());
        await Db.getTokenKey().then((value) {
          userToken = value!;
        });

        Fluttertoast.showToast(msg: jsonResponse['message']);

        final route =
            MaterialPageRoute(builder: (context) => const HomeScreen());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(msg: jsonResponse["message"].toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (error) {
      log('Error: $error');
      if (error is SocketException) {
        Fluttertoast.showToast(msg: "No internet connection");
      } else if (error is FormatException) {
        Fluttertoast.showToast(msg: "Unsupported media type");
      } else {
        Fluttertoast.showToast(msg: "An error occurred");
      }
    }
  }

  // get user detail
  static Future<UserDetailModel?> getUserRequest(BuildContext context) async {
    String? userToken;
    await Db.getTokenKey().then((value) {
      userToken = value;
      log("this is the token" + value.toString());
    });
    try {
      var response = await http.get(
        Uri.parse(ServerDetails.userList),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $userToken'
        },
      );

      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      UserDetailModel? userDetailModel;
      log("jsonResponse : " + jsonResponse.toString());

      if (jsonResponse["status"] == true &&
          jsonResponse["message"] == "Success") {
        userDetailModel = userDetailModelFromJson(response.body);
      } else if (jsonResponse["status"] == false) {
        Fluttertoast.showToast(msg: jsonResponse["message"]);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        final route = MaterialPageRoute(builder: (context) => LoginScreen());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
      return userDetailModel;
    } catch (e) {
      log("Error");
    }
  }

  static Future<void> logOutRequest(BuildContext context) async {
    String? userToken;
    await Db.getTokenKey().then((value) {
      userToken = value;
      print("here i am" + value.toString());
    });

    var request = {};
    var response = await http.get(
      Uri.parse(ServerDetails.logout),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $userToken',
      },
    );
    log('this response of new api${response.body}');
    log('this response of new api${request}');

    Map<String, dynamic> jsonResponse =
        json.decode(utf8.decode(response.bodyBytes));
    print(jsonResponse);
    if (jsonResponse["status"] == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();

      Fluttertoast.showToast(msg: jsonResponse["message"]);
      final route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (jsonResponse["status"] == false) {
    } else {}
  }
}
