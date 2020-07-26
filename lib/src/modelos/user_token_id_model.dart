// To parse this JSON data, do
//
//     final tokenId = tokenIdFromJson(jsonString);

import 'dart:convert';

TokenId tokenIdFromJson(String str) => TokenId.fromJson(json.decode(str));

String tokenIdToJson(TokenId data) => json.encode(data.toJson());

class TokenId {
  TokenId({
    this.kind,
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
    this.refreshToken,
    this.expiresIn,
  });

  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String refreshToken;
  String expiresIn;

  factory TokenId.fromJson(Map<String, dynamic> json) => TokenId(
    kind: json["kind"],
    localId: json["localId"],
    email: json["email"],
    displayName: json["displayName"],
    idToken: json["idToken"],
    registered: json["registered"],
    refreshToken: json["refreshToken"],
    expiresIn: json["expiresIn"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "localId": localId,
    "email": email,
    "displayName": displayName,
    "idToken": idToken,
    "registered": registered,
    "refreshToken": refreshToken,
    "expiresIn": expiresIn,
  };
}
