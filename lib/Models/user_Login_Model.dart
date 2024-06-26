// To parse this JSON data, do
//
//     final userloginModel = userloginModelFromJson(jsonString);

import 'dart:convert';

UserloginModel userloginModelFromJson(String str) =>
    UserloginModel.fromJson(json.decode(str));

String userloginModelToJson(UserloginModel data) => json.encode(data.toJson());

class UserloginModel {
  bool status;
  String message;
  Record record;

  UserloginModel({
    required this.status,
    required this.message,
    required this.record,
  });

  factory UserloginModel.fromJson(Map<String, dynamic> json) => UserloginModel(
        status: json["status"],
        message: json["message"],
        record: Record.fromJson(json["record"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "record": record.toJson(),
      };
}

class Record {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String profileImg;
  String authtoken;

  Record({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.profileImg,
    required this.authtoken,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        profileImg: json["profileImg"],
        authtoken: json["authtoken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phoneNo,
        "profileImg": profileImg,
        "authtoken": authtoken,
      };
}
