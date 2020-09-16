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
    this.stores
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
    this.originalStoreName,
    this.storeTagName,
    this.categoryName,
    this.iconUrl,
    this.provinceName,
    this.description,
    this.storeName,
    this.hexColor,
  });

  String originalStoreName;
  String storeTagName;
  String categoryName;
  String iconUrl;
  String provinceName;
  String description;
  String storeName;
  String hexColor;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        originalStoreName: json["original_store_name"],
        storeTagName: json["store_tag_name"],
        categoryName: json["category_name"],
        iconUrl: json["icon_url"],
        provinceName: json["province_name"],
        description: json["description"],
        storeName: json["store_name"],
        hexColor: json["hex_color"],
      );

  Map<String, dynamic> toJson() => {
        "original_store_name": originalStoreName,
        "store_tag_name": storeTagName,
        "category_name": categoryName,
        "icon_url": iconUrl,
        "province_name": provinceName,
        "description": description,
        "store_name": storeName,
        "hex_color": hexColor,
      };
}
