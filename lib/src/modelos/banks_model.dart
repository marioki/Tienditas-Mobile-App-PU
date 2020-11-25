import 'dart:convert';

BanksModel banksModelFromJson(String str) => BanksModel.fromJson(json.decode(str));

String banksModelToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
  BanksModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
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
    this.accountType,
    this.banks,
  });

  List<String> accountType;
  List<String> banks;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    accountType: List<String>.from(json["account_type"].map((x) => x)),
    banks: List<String>.from(json["banks"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "account_type": List<dynamic>.from(accountType.map((x) => x)),
    "banks": List<dynamic>.from(banks.map((x) => x)),
  };
}
