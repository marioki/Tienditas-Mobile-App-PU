import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
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
    this.province,
  });

  Province province;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    province: Province.fromJson(json["province"]),
  );

  Map<String, dynamic> toJson() => {
    "province": province.toJson(),
  };
}

class Province {
  Province({
    this.provinces,
  });

  List<dynamic> provinces;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
      provinces: json["provinces"]
  );

  Map<String, dynamic> toJson() => {
    "provinces": provinces
  };
}