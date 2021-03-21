// To parse this JSON data, do
//
//     final userTienditaResult = userTienditaResultFromJson(jsonString);

import 'dart:convert';

UserTienditaResult userTienditaResultFromJson(String str) =>
    UserTienditaResult.fromJson(json.decode(str));

String userTienditaResultToJson(UserTienditaResult data) =>
    json.encode(data.toJson());

class UserTienditaResult {
  UserTienditaResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory UserTienditaResult.fromJson(Map<String, dynamic> json) =>
      UserTienditaResult(
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

  UserTienditas user;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        user: UserTienditas.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class UserTienditas {
  UserTienditas({
    this.creditCard,
    this.registeredDate,
    this.bankAccounts,
    this.name,
    this.stores,
    this.address,
    this.preferences,
    this.userEmail,
    this.phoneNumber
  });

  List<dynamic> creditCard;
  List<BankAccount> bankAccounts;
  String registeredDate;
  String name;
  String email;
  List<dynamic> stores;
  List<Address> address;
  List<dynamic> preferences;
  String userEmail;
  String phoneNumber;

  factory UserTienditas.fromJson(Map<String, dynamic> json) => UserTienditas(
        registeredDate: json["registered_date"],
        name: json["name"],
        stores: List<dynamic>.from(json["stores"].map((x) => x)),
        bankAccounts: List<BankAccount>.from(json["bank_accounts"].map((x) => BankAccount.fromJson(x))),
        address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        preferences: List<dynamic>.from(json["preferences"].map((x) => x)),
        userEmail: json["email"],
        phoneNumber: json["phone_number"]
      );

  Map<String, dynamic> toJson() => {
        "registered_date": registeredDate,
        "name": name,
        "#email": email,
        "stores": List<dynamic>.from(stores.map((x) => x)),
        "bank_accounts": List<dynamic>.from(bankAccounts.map((x) => x.toJson())),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "preferences": List<dynamic>.from(preferences.map((x) => x)),
        "email": userEmail,
        "phone_number": phoneNumber
      };
}

class BankAccount {
  BankAccount({
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.id,
    this.isDefault,
  });

  String bankName;
  String accountNumber;
  String accountType;
  String id;
  bool isDefault;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    accountType: json["account_type"],
    id: json["id"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "account_number": accountNumber,
    "account_type": accountType,
    "id": id,
    "is_default": isDefault,
  };
}

class Address {
  Address({
    this.id,
    this.country,
    this.referencePoint,
    this.province,
    this.name,
    this.addressLine1,
    this.phoneNumber,
    this.isDefault,
    this.latitude,
    this.longitude
  });

  String id;
  String country;
  String referencePoint;
  String province;
  String name;
  String addressLine1;
  String phoneNumber;
  String isDefault;
  String latitude;
  String longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        country: json["country"],
        referencePoint: json["reference_point"],
        province: json["province"],
        name: json["name"],
        addressLine1: json["address_line_1"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        isDefault: json["is_default"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "reference_point": referencePoint,
        "province": province,
        "name": name,
        "address_line_1": addressLine1,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "is_default": isDefault,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
