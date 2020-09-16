import 'dart:convert';

StoreModel storeResultFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeResultToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  StoreModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
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
    this.balance,
    this.categoryName,
    this.deliveryOptions,
    this.iconUrl,
    this.provinceName,
    this.description,
    this.pendingBalance,
    this.storeName,
    this.hexColor,
    this.storeStatus,
  });

  String originalStoreName;
  String storeTagName;
  String balance;
  String categoryName;
  List<DeliveryOption> deliveryOptions;
  String iconUrl;
  String provinceName;
  String description;
  String pendingBalance;
  String storeName;
  String hexColor;
  String storeStatus;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
      originalStoreName: json["original_store_name"],
      storeTagName: json["store_tag_name"],
      balance: json["balance"],
      categoryName: json["category_name"],
      deliveryOptions: List<DeliveryOption>.from(json["delivery_options"].map((x) => DeliveryOption.fromJson(x))),
      iconUrl: json["icon_url"],
      provinceName: json["province_name"],
      description: json["description"],
      pendingBalance: json["pending_balance"],
      storeName: json["store_name"],
      hexColor: json["hex_color"],
      storeStatus: json["store_status"]
  );

  Map<String, dynamic> toJson() => {
    "original_store_name": originalStoreName,
    "store_tag_name": storeTagName,
    "balance": balance,
    "category_name": categoryName,
    "delivery_options": List<dynamic>.from(deliveryOptions.map((x) => x.toJson())),
    "icon_url": iconUrl,
    "province_name": provinceName,
    "description": description,
    "pending_balance": pendingBalance,
    "store_name": storeName,
    "hex_color": hexColor,
    "store_status":  storeStatus
  };
}

class DeliveryOption {
  DeliveryOption({
    this.id,
    this.method,
    this.name,
    this.fee,
  });

  String id;
  String method;
  String name;
  String fee;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
    id: json["id"],
    method: json["method"],
    name: json["name"],
    fee: json["fee"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method": method,
    "name": name,
    "fee": fee,
  };
}