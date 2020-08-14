// To parse this JSON data, do
//
//     final creditCardResult = creditCardResultFromJson(jsonString);

import 'dart:convert';

CreditCardResult creditCardResultFromJson(String str) => CreditCardResult.fromJson(json.decode(str));

String creditCardResultToJson(CreditCardResult data) => json.encode(data.toJson());

class CreditCardResult {
  CreditCardResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory CreditCardResult.fromJson(Map<String, dynamic> json) => CreditCardResult(
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
    this.creditCards,
    this.email,
    this.registeredDate,
  });

  List<CreditCard> creditCards;
  String email;
  String registeredDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
    creditCards: List<CreditCard>.from(json["credit_cards"].map((x) => CreditCard.fromJson(x))),
    email: json["email"],
    registeredDate: json["registered_date"],
  );

  Map<String, dynamic> toJson() => {
    "credit_cards": List<dynamic>.from(creditCards.map((x) => x.toJson())),
    "email": email,
    "registered_date": registeredDate,
  };
}

class CreditCard {
  CreditCard({
    this.number,
    this.cvv,
    this.id,
    this.expirationDate,
    this.holderName,
  });

  String number;
  String cvv;
  String id;
  String expirationDate;
  String holderName;

  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
    number: json["number"],
    cvv: json["cvv"],
    id: json["id"],
    expirationDate: json["expiration_date"],
    holderName: json["holder_name"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "cvv": cvv,
    "id": id,
    "expiration_date": expirationDate,
    "holder_name": holderName,
  };
}
