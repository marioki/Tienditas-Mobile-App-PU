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
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductElement {
  ProductElement({
    this.quantity,
    this.itemName,
    this.purchaseType,
    this.outstanding,
    this.registeredDate,
    this.itemId,
    this.finalPrice,
    this.itemSatus,
    this.imageUrl,
    this.hexColor
  });

  String quantity;
  String itemName;
  PurchaseType purchaseType;
  Outstanding outstanding;
  String registeredDate;
  String itemId;
  String finalPrice;
  ItemSatus itemSatus;
  String imageUrl;
  //===Added Properties for cart page
  int cartItemAmount;
  String hexColor;


  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    quantity: json["quantity"],
    itemName: json["item_name"],
    purchaseType: purchaseTypeValues.map[json["purchase_type"]],
    outstanding: outstandingValues.map[json["outstanding"]],
    registeredDate: json["registered_date"],
    itemId: json["item_id"],
    finalPrice: json["final_price"],
    itemSatus: itemSatusValues.map[json["item_satus"]],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "item_name": itemName,
    "purchase_type": purchaseTypeValues.reverse[purchaseType],
    "outstanding": outstandingValues.reverse[outstanding],
    "registered_date": registeredDate,
    "item_id": itemId,
    "final_price": finalPrice,
    "item_satus": itemSatusValues.reverse[itemSatus],
    "image_url": imageUrl,
  };
}

enum ItemSatus { VIGENTE }

final itemSatusValues = EnumValues({
  "VIGENTE": ItemSatus.VIGENTE
});

enum Outstanding { FALSE }

final outstandingValues = EnumValues({
  "FALSE": Outstanding.FALSE
});

enum PurchaseType { NORMAL }

final purchaseTypeValues = EnumValues({
  "NORMAL": PurchaseType.NORMAL
});

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
