// To parse this JSON data, do
//
//     final deliveryOptionsResponse = deliveryOptionsResponseFromJson(jsonString);

import 'dart:convert';

DeliveryOptionsResponse deliveryOptionsResponseFromJson(String str) =>
    DeliveryOptionsResponse.fromJson(json.decode(str));

String deliveryOptionsResponseToJson(DeliveryOptionsResponse data) =>
    json.encode(data.toJson());

class DeliveryOptionsResponse {
  DeliveryOptionsResponse({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory DeliveryOptionsResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionsResponse(
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
    this.store,
  });

  StoreDeliveryInfo store;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        store: StoreDeliveryInfo.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "store": store.toJson(),
      };
}

class StoreDeliveryInfo {
  StoreDeliveryInfo({
    this.originalStoreName,
    this.storeTagName,
    this.categoryName,
    this.deliveryOptions,
    this.iconUrl,
    this.provinceName,
    this.description,
    this.storeName,
  });

  String originalStoreName;
  String storeTagName;
  String categoryName;
  List<DeliveryOption> deliveryOptions;
  String iconUrl;
  String provinceName;
  String description;
  String storeName;

  factory StoreDeliveryInfo.fromJson(Map<String, dynamic> json) =>
      StoreDeliveryInfo(
        originalStoreName: json["original_store_name"],
        storeTagName: json["store_tag_name"],
        categoryName: json["category_name"],
        deliveryOptions: List<DeliveryOption>.from(
            json["delivery_options"].map((x) => DeliveryOption.fromJson(x))),
        iconUrl: json["icon_url"],
        provinceName: json["province_name"],
        description: json["description"],
        storeName: json["store_name"],
      );

  Map<String, dynamic> toJson() => {
        "original_store_name": originalStoreName,
        "store_tag_name": storeTagName,
        "category_name": categoryName,
        "delivery_options":
            List<dynamic>.from(deliveryOptions.map((x) => x.toJson())),
        "icon_url": iconUrl,
        "province_name": provinceName,
        "description": description,
        "store_name": storeName,
      };
}

class DeliveryOption {
  DeliveryOption({
    this.method,
    this.name,
    this.fee,
    this.selectedIndex,
  });

  String method;
  String name;
  String fee;
  int selectedIndex;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
        method: json["method"],
        name: json["name"],
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "name": name,
        "fee": fee,
      };
}
