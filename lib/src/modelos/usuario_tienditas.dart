// To parse this JSON data, do
//
//     final userTienditaResult = userTienditaResultFromJson(jsonString);

import 'dart:convert';

UserTienditaResult userTienditaResultFromJson(String str) => UserTienditaResult.fromJson(json.decode(str));

String userTienditaResultToJson(UserTienditaResult data) => json.encode(data.toJson());

class UserTienditaResult {
  UserTienditaResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory UserTienditaResult.fromJson(Map<String, dynamic> json) => UserTienditaResult(
    statusCode: json["statusCode"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body.toJson(),
  };
}

class Body {
  Body({
    this.user,
  });

  User user;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  User({
    this.creditCard,
    this.registeredDate,
    this.lastName,
    this.firstName,
    this.email,
    this.stores,
    this.address,
    this.preferences,
    this.userEmail,
  });

  List<dynamic> creditCard;
  String registeredDate;
  String lastName;
  String firstName;
  String email;
  List<dynamic> stores;
  List<Address> address;
  List<dynamic> preferences;
  String userEmail;

  factory User.fromJson(Map<String, dynamic> json) => User(
    creditCard: List<dynamic>.from(json["credit_card"].map((x) => x)),
    registeredDate: json["registered_date"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    email: json["#email"],
    stores: List<dynamic>.from(json["stores"].map((x) => x)),
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    preferences: List<dynamic>.from(json["preferences"].map((x) => x)),
    userEmail: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "credit_card": List<dynamic>.from(creditCard.map((x) => x)),
    "registered_date": registeredDate,
    "last_name": lastName,
    "first_name": firstName,
    "#email": email,
    "stores": List<dynamic>.from(stores.map((x) => x)),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "preferences": List<dynamic>.from(preferences.map((x) => x)),
    "email": userEmail,
  };
}

class Address {
  Address({
    this.country,
    this.referencePoint,
    this.province,
    this.name,
    this.addressLine1,
    this.phoneNumber,
    this.isDefault,
  });

  String country;
  String referencePoint;
  String province;
  String name;
  String addressLine1;
  String phoneNumber;
  String isDefault;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    referencePoint: json["reference_point"],
    province: json["province"],
    name: json["name"],
    addressLine1: json["address_line_1"],
    phoneNumber: json["phone_number"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "reference_point": referencePoint,
    "province": province,
    "name": name,
    "address_line_1": addressLine1,
    "phone_number": phoneNumber,
    "is_default": isDefault,
  };
}
