// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

ResponseTienditasApi responseFromJson(String str) => ResponseTienditasApi.fromJson(json.decode(str));

String responseToJson(ResponseTienditasApi data) => json.encode(data.toJson());

class ResponseTienditasApi {
  ResponseTienditasApi({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory ResponseTienditasApi.fromJson(Map<String, dynamic> json) => ResponseTienditasApi(
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
    this.message,
  });

  String message;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
