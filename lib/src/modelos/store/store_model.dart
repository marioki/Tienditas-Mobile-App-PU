import 'dart:convert';

StoreResult storeResultFromJson(String str) => StoreResult.fromJson(json.decode(str));

String storeResultToJson(StoreResult data) => json.encode(data.toJson());

class StoreResult {
  StoreResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory StoreResult.fromJson(Map<String, dynamic> json) =>
      StoreResult(
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

  Store store;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    store: Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "store": store.toJson(),
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
    this.pendingBalance,
    this.balance
  });

  String originalStoreName;
  String storeTagName;
  String categoryName;
  String iconUrl;
  String provinceName;
  String description;
  String storeName;
  String hexColor;
  String pendingBalance;
  String balance;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    originalStoreName: json["original_store_name"],
    storeTagName: json["store_tag_name"],
    categoryName: json["category_name"],
    iconUrl: json["icon_url"],
    provinceName: json["province_name"],
    description: json["description"],
    storeName: json["store_name"],
    hexColor: json["hex_color"],
    pendingBalance: json["pending_balance"],
    balance: json["balance"]
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
    "pending_balance": pendingBalance,
    "balance": balance
  };
}