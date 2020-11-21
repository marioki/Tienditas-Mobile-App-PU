// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    this.products,
  });

  List<ProductElement> products;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductElement {
  ProductElement({
    this.storeTagName,
    this.quantity,
    this.itemName,
    this.description,
    this.purchaseType,
    this.outstanding,
    this.registeredDate,
    this.itemId,
    this.finalPrice,
    this.basePrice,
    this.itemStatus,
    this.imageUrl,
    this.hexColor,
    this.parentStoreTag,
    this.deliveryTime,
    this.discountPercentage,
    this.discountPrice
  });

  String storeTagName;
  String quantity;
  String itemName;
  String description;
  PurchaseType purchaseType;
  Outstanding outstanding;
  String registeredDate;
  String itemId;
  String finalPrice;
  String basePrice;
  ItemSatus itemStatus;
  String imageUrl;
  String discountPercentage;
  String discountPrice;

  //===Added Properties for cart page
  int cartItemAmount = 1;
  String parentStoreTag;
  String hexColor;

  String deliveryTime;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        storeTagName: json["store_tag_name"],
        quantity: json["quantity"],
        itemName: json["item_name"],
        description: json["description"],
        purchaseType: purchaseTypeValues.map[json["purchase_type"]],
        outstanding: outstandingValues.map[json["outstanding"]],
        registeredDate: json["registered_date"],
        itemId: json["item_id"],
        finalPrice: json["final_price"],
        basePrice: json["base_price"],
        itemStatus: itemSatusValues.map[json["item_status"]],
        imageUrl: json["image_url"],
        deliveryTime: json["delivery_time"],
        discountPercentage: json["discount_percentage"],
        discountPrice: json["discount_price"],

      );

  Map<String, dynamic> toJson() => {
        "store_tag_name": storeTagName,
        "quantity": quantity,
        "item_name": itemName,
        "description": description,
        "purchase_type": purchaseTypeValues.reverse[purchaseType],
        "outstanding": outstandingValues.reverse[outstanding],
        "registered_date": registeredDate,
        "item_id": itemId,
        "final_price": finalPrice,
        "base_price": basePrice,
        "item_status": itemSatusValues.reverse[itemStatus],
        "image_url": imageUrl,
        "delivery_time": deliveryTime,
        "discount_price": discountPrice,
        "discount_percentage": discountPercentage
      };
}

enum ItemSatus { VIGENTE }

final itemSatusValues = EnumValues({"VIGENTE": ItemSatus.VIGENTE});

enum Outstanding { FALSE }

final outstandingValues = EnumValues({"FALSE": Outstanding.FALSE});

enum PurchaseType { NORMAL }

final purchaseTypeValues = EnumValues({"NORMAL": PurchaseType.NORMAL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
