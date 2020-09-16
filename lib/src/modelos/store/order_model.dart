import 'dart:convert';

StoreOrdersResult storeOrderFromJson(String str) => StoreOrdersResult.fromJson(json.decode(str));

String storeOrderToJson(StoreOrdersResult data) => json.encode(data.toJson());

class StoreOrdersResult {
  StoreOrdersResult({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory StoreOrdersResult.fromJson(Map<String, dynamic> json) =>
      StoreOrdersResult(
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
    this.orders,
  });

  List<Order> orders;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    this.storeTagName,
    this.orderStatus,
    this.orderElements,
    this.orderDate,
    this.paymentMethod,
    this.userEmail,
    this.amount,
    this.userAddress,
    this.orderId,
    this.userName,
    this.deliveryOption,
    this.phoneNumber,
    this.orderStatusOrderDate,
  });

  String storeTagName;
  String orderStatus;
  List<OrderElement> orderElements;
  String orderDate;
  String paymentMethod;
  String userEmail;
  String amount;
  UserAddress userAddress;
  String orderId;
  String userName;
  DeliveryOption deliveryOption;
  String phoneNumber;
  String orderStatusOrderDate;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    storeTagName: json["store_tag_name"],
    orderStatus: json["order_status"],
    orderElements: List<OrderElement>.from(json["order_elements"].map((x) => OrderElement.fromJson(x))),
    orderDate: json["order_date"],
    paymentMethod: json["payment_method"],
    userEmail: json["user_email"],
    amount: json["amount"],
    userAddress: UserAddress.fromJson(json["user_address"]),
    orderId: json["order_id"],
    userName: json["user_name"],
    deliveryOption: DeliveryOption.fromJson(json["delivery_option"]),
    phoneNumber: json["phone_number"],
    orderStatusOrderDate: json["order_status-order_date"],
  );

  Map<String, dynamic> toJson() => {
    "store_tag_name": storeTagName,
    "order_status": orderStatus,
    "order_elements": List<dynamic>.from(orderElements.map((x) => x.toJson())),
    "order_date": orderDate,
    "payment_method": paymentMethod,
    "user_email": userEmail,
    "amount": amount,
    "user_address": userAddress.toJson(),
    "order_id": orderId,
    "user_name": userName,
    "delivery_option": deliveryOption.toJson(),
    "phone_number": phoneNumber,
    "order_status-order_date": orderStatusOrderDate,
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
    this.quantity,
    this.itemName
  });

  String itemId;
  String quantity;
  String itemName;

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
      itemId: json["item_id"],
      quantity: json["quantity"],
      itemName: json["item_name"]
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "quantity": quantity,
    "item_name": itemName,
  };
}

class UserAddress {
  UserAddress({
    this.addressLine1,
    this.country,
    this.referencePoint,
    this.province,
    this.phoneNumber,
  });

  String addressLine1;
  String country;
  String referencePoint;
  String province;
  String phoneNumber;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    addressLine1: json["address_line_1"],
    country: json["country"],
    referencePoint: json["reference_point"],
    province: json["province"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "address_line_1": addressLine1,
    "country": country,
    "reference_point": referencePoint,
    "province": province,
    "phone_number": phoneNumber == null ? null : phoneNumber,
  };
}
