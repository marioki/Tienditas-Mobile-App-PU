// To parse this JSON data, do
//
//     final tiendita = tienditaFromJson(jsonString);

import 'dart:convert';

Tiendita tienditaFromJson(String str) => Tiendita.fromJson(json.decode(str));

String tienditaToJson(Tiendita data) => json.encode(data.toJson());

class Tiendita {
  Tiendita({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory Tiendita.fromJson(Map<String, dynamic> json) => Tiendita(
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
    this.stores,
  });

  List<Store> stores;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
  };
}

class Store {
  Store({
    this.storeTagName,
    this.hexColor,
    this.registeredDate,
    this.categoryName,
    this.storeStatus,
    this.iconUrl,
    this.phoneNumber,
    this.provinceName,
    this.storeName,
  });

  String storeTagName;
  String hexColor;
  String registeredDate;
  String categoryName;
  String storeStatus;
  String iconUrl;
  String phoneNumber;
  String provinceName;
  String storeName;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    storeTagName: json["store_tag_name"],
    hexColor: json["hex_color"],
    registeredDate: json["registered_date"],
    categoryName: json["category_name"],
    storeStatus: json["store_status"],
    iconUrl: json["icon_url"],
    phoneNumber: json["phone_number"],
    provinceName: json["province_name"],
    storeName: json["store_name"],
  );

  Map<String, dynamic> toJson() => {
    "store_tag_name": storeTagName,
    "hex_color": hexColor,
    "registered_date": registeredDate,
    "category_name": categoryName,
    "store_status": storeStatus,
    "icon_url": iconUrl,
    "phone_number": phoneNumber,
    "province_name": provinceName,
    "store_name": storeName,
  };
}
