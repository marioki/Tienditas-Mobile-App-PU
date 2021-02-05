import 'dart:convert';

import 'package:flutter/cupertino.dart';

Batch batchFromJson(String str) => Batch.fromJson(json.decode(str));

String batchToJson(Batch data) => json.encode(data.toJson());

class BatchResult {
  BatchResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory BatchResult.fromJson(Map<String, dynamic> json) => BatchResult(
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
    this.batch,
  });

  Batch batch;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        batch: Batch.fromJson(json["batch"]),
      );

  Map<String, dynamic> toJson() => {
        "batch": batch.toJson(),
      };
}

class Batch {
  Batch({
    this.totalAmount,
    this.creditCardId,
    this.paymentMethod,
    this.userName,
    this.userEmail,
    this.phoneNumber,
    this.orders,
  });

  String totalAmount;
  String creditCardId;
  String paymentMethod;
  String userName;
  String userEmail;
  String phoneNumber;
  List<Order> orders;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        totalAmount: json["total_amount"],
        creditCardId: json["credit_card_id"],
        paymentMethod: json["payment_method"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        phoneNumber: json["phone_number"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "credit_card_id": creditCardId,
        "payment_method": paymentMethod,
        "user_name": userName,
        "user_email": userEmail,
        "phone_number": phoneNumber,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.amount,
    this.storeTagName,
    this.elements,
    this.userAddress,
    this.deliveryOption,
  });

  String amount;
  String storeTagName;
  List<ProductItem> elements;
  UserAddress userAddress;
  BatchOrderDeliveryOption deliveryOption;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        amount: json["amount"],
        storeTagName: json["store_tag_name"],
        elements: List<ProductItem>.from(
            json["elements"].map((x) => ProductItem.fromJson(x))),
        userAddress: UserAddress.fromJson(json["user_address"]),
        deliveryOption:
            BatchOrderDeliveryOption.fromJson(json["delivery_option"]),
      );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "store_tag_name": storeTagName,
    "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
    "user_address": userAddress.toJson(),
    "delivery_option": deliveryOption.toJson(),
  };
}

class BatchOrderDeliveryOption {
  BatchOrderDeliveryOption({
    this.name,
    this.fee,
    this.method,
  });

  String name;
  String fee;
  String method;

  factory BatchOrderDeliveryOption.fromJson(Map<String, dynamic> json) =>
      BatchOrderDeliveryOption(
        name: json["name"],
        fee: json["fee"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fee": fee,
    "method": method,
  };
}

class ProductItem {
  ProductItem(
      {this.itemId,
        this.quantity,
        //Added for resmuen display of products
        this.productName,
        this.itemPrice});

  String itemId;
  String quantity;
  String productName;
  double itemPrice;

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        itemId: json["item_id"],
        quantity: json["quantity"],
        productName: json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "quantity": quantity,
        "item_name": productName,
      };
}

class UserAddress {
  UserAddress({
    this.addressLine1,
    this.referencePoint,
    this.country,
    this.province,
    this.phoneNumber,
  });

  String addressLine1;
  String referencePoint;
  String country;
  String province;
  String phoneNumber;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    addressLine1: json["address_line_1"],
    referencePoint: json["reference_point"],
    country: json["country"],
    province: json["province"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "address_line_1": addressLine1,
    "reference_point": referencePoint,
    "country": country,
    "province": province,
    "phone_number": phoneNumber,
  };
}