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
    batches: List<Batch>.from(json["batches"].map((x) => Batch.fromJson(x))),
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
  String batchDate;
  String totalAmount;
  String userEmail;
  List<Order> orders;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
    batchId: json["batch_id"],
    batchDate: json["batch_date"],
    totalAmount: json["total_amount"],
    userEmail: json["user_email"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "batch_id": batchId,
    "batch_date": batchDate,
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
        this.userConfirmation,
        this.phoneNumber,
        this.amount,
        this.orderId,
        this.userAddress,
        this.userName,
        this.deliveryOption,
    });

    String storeTagName;
    List<OrderElement> orderElements;
    String orderStatus;
    String orderDate;
    String paymentMethod;
    String userConfirmation;
    String phoneNumber;
    String amount;
    String orderId;
    UserAddress userAddress;
    String userName;
    DeliveryOption deliveryOption;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        storeTagName: json["store_tag_name"],
        orderElements: List<OrderElement>.from(json["order_elements"].map((x) => OrderElement.fromJson(x))),
        orderStatus: json["order_status"],
        orderDate: json["order_date"],
        paymentMethod: json["payment_method"],
        userConfirmation: json["user_confirmation"],
        phoneNumber: json["phone_number"],
        amount: json["amount"],
        orderId: json["order_id"],
        userAddress: UserAddress.fromJson(json["user_address"]),
        userName: json["user_name"],
        deliveryOption: DeliveryOption.fromJson(json["delivery_option"]),
    );

    Map<String, dynamic> toJson() => {
        "store_tag_name": storeTagName,
        "order_elements": List<dynamic>.from(orderElements.map((x) => x.toJson())),
        "order_status": orderStatus,
        "order_date": orderDate,
        "payment_method": paymentMethod,
        "user_confirmation": userConfirmation,
        "phone_number": phoneNumber,
        "amount": amount,
        "order_id": orderId,
        "user_address": userAddress.toJson(),
        "user_name": userName,
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
  OrderElement({
    this.itemId,
    this.itemName,
    this.quantity,
  });

  String itemId;
  String itemName;
  String quantity;

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
    itemId: json["item_id"],
    itemName: json["item_name"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "quantity": quantity,
  };
}

class UserAddress {
  UserAddress({
    this.country,
    this.referencePoint,
    this.province,
    this.latitude,
    this.addressLine1,
    this.phoneNumber,
    this.longitude,
  });

  String country;
  String referencePoint;
  String province;
  String latitude;
  String addressLine1;
  String phoneNumber;
  String longitude;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
      country: json["country"] == null ? null : json["country"],
      referencePoint: json["reference_point"] == null ? null : json["reference_point"],
      province: json["province"] == null ? null : json["province"],
      latitude: json["latitude"] == null ? null : json["latitude"],
      addressLine1: json["address_line_1"] == null ? null : json["address_line_1"],
      phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
    "country": country == null ? null : country,
    "reference_point": referencePoint == null ? null : referencePoint,
    "province": province == null ? null : province,
    "latitude": latitude == null ? null : latitude,
    "address_line_1": addressLine1 == null ? null : addressLine1,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "longitude": longitude == null ? null : longitude,
  };
}
