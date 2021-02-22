import 'dart:convert';

UserOrderBatchModel userBatchFromJson(String str) =>
    UserOrderBatchModel.fromJson(json.decode(str));

String userBatchToJson(UserOrderBatchModel data) => json.encode(data.toJson());

class UserOrderBatchModel {
  UserOrderBatchModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory UserOrderBatchModel.fromJson(Map<String, dynamic> json) =>
      UserOrderBatchModel(
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
    this.batches,
  });

  List<Batch> batches;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        batches:
            List<Batch>.from(json["batches"].map((x) => Batch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batches": List<dynamic>.from(batches.map((x) => x.toJson())),
      };
}

class Batch {
  Batch({
    this.batchId,
    this.batchDate,
    this.totalAmount,
    this.userEmail,
    this.orders,
  });

  String batchId;
  DateTime batchDate;
  String totalAmount;
  String userEmail;
  List<Order> orders;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        batchId: json["batch_id"],
        batchDate: DateTime.parse(json["batch_date"]),
        totalAmount: json["total_amount"],
        userEmail: json["user_email"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "batch_date": batchDate.toIso8601String(),
        "total_amount": totalAmount,
        "user_email": userEmail,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.storeTagName,
    this.orderElements,
    this.orderStatus,
    this.orderDate,
    this.paymentMethod,
    this.amount,
    this.orderId,
    this.userAddress,
    this.deliveryOption,
    this.userConfirmation,
  });

  String storeTagName;
  List<OrderElement> orderElements;
  String orderStatus;
  DateTime orderDate;
  String paymentMethod;
  String amount;
  String orderId;
  String userConfirmation;
  UserAddress userAddress;
  DeliveryOption deliveryOption;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        storeTagName: json["store_tag_name"],
        orderElements: List<OrderElement>.from(
            json["order_elements"].map((x) => OrderElement.fromJson(x))),
        orderStatus: json["order_status"],
        orderDate: DateTime.parse(json["order_date"]),
        paymentMethod: json["payment_method"],
        amount: json["amount"],
        orderId: json["order_id"],
        userConfirmation: json["user_confirmation"],
        userAddress: UserAddress.fromJson(json["user_address"]),
        deliveryOption: DeliveryOption.fromJson(json["delivery_option"]),
      );

  Map<String, dynamic> toJson() => {
        "store_tag_name": storeTagName,
        "order_elements":
            List<dynamic>.from(orderElements.map((x) => x.toJson())),
        "order_status": orderStatus,
        "order_date": orderDate.toIso8601String(),
        "payment_method": paymentMethod,
        "amount": amount,
        "order_id": orderId,
        "user_address": userAddress.toJson(),
        "delivery_option": deliveryOption.toJson(),
      };
}

class DeliveryOption {
  DeliveryOption({
    this.name,
    this.method,
    this.fee,
  });

  String name;
  String method;
  String fee;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
        name: json["name"],
        method: json["method"],
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "method": method,
        "fee": fee,
      };
}

class OrderElement {
  OrderElement({this.itemId, this.quantity, this.itemName});

  String itemId;
  String quantity;
  String itemName;

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
      itemId: json["item_id"],
      quantity: json["quantity"],
      itemName: json["item_name"]);

  Map<String, dynamic> toJson() =>
      {"item_id": itemId, "quantity": quantity, "item_name": itemName};
}

class UserAddress {
  UserAddress({
    this.addressLine1,
    this.country,
    this.referencePoint,
    this.province,
    this.phoneNumber,
    this.longitude,
    this.latitude
  });

  String addressLine1;
  String country;
  String referencePoint;
  String province;
  String phoneNumber;
  String longitude;
  String latitude;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
      addressLine1: json["address_line_1"],
      country: json["country"],
      referencePoint: json["reference_point"],
      province: json["province"],
      phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      latitude: json["latitude"] == null ? null : json["latitude"],
      longitude: json["longitude"] == null ? null : json["longitude"],);

  Map<String, dynamic> toJson() => {
        "address_line_1": addressLine1,
        "country": country,
        "reference_point": referencePoint,
        "province": province,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
