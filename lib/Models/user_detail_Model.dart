// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
    bool status;
    String message;
    List<UserList> userList;
    int currentPage;
    int lastPage;
    int total;
    int perPage;

    UserDetailModel({
        required this.status,
        required this.message,
        required this.userList,
        required this.currentPage,
        required this.lastPage,
        required this.total,
        required this.perPage,
    });

    factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
        status: json["status"],
        message: json["message"],
        userList: List<UserList>.from(json["userList"].map((x) => UserList.fromJson(x))),
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        total: json["total"],
        perPage: json["perPage"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
        "currentPage": currentPage,
        "lastPage": lastPage,
        "total": total,
        "perPage": perPage,
    };
}

class UserList {
    int id;
    String firstName;
    String lastName;
    String email;
    String countryCode;
    String phoneNo;
    String status;

    UserList({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.countryCode,
        required this.phoneNo,
        required this.status,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phoneNo: json["phone_no"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "phone_no": phoneNo,
        "status": status,
    };
}
