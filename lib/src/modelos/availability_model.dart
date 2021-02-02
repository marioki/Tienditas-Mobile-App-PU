// To parse this JSON data, do
//
//     final availability = availabilityFromJson(jsonString);

import 'dart:convert';

AvailabilityResponse availabilityFromJson(String str) => AvailabilityResponse.fromJson(json.decode(str));

String availabilityToJson(AvailabilityResponse data) => json.encode(data.toJson());

class AvailabilityResponse {
    AvailabilityResponse({
        this.statusCode,
        this.body,
    });

    int statusCode;
    Body body;

    factory AvailabilityResponse.fromJson(Map<String, dynamic> json) => AvailabilityResponse(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "body": body == null ? null : body.toJson(),
    };
}

class Body {
    Body({
        this.message,
        this.available,
        this.notAvailable,
    });

    String message;
    List<Available> available;
    List<Available> notAvailable;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        message: json["message"] == null ? null : json["message"],
        available: json["available"] == null ? null : List<Available>.from(json["available"].map((x) => Available.fromJson(x))),
        notAvailable: json["not_available"] == null ? null : List<Available>.from(json["not_available"].map((x) => Available.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "available": available == null ? null : List<dynamic>.from(available.map((x) => x.toJson())),
        "not_available": notAvailable == null ? null : List<dynamic>.from(notAvailable.map((x) => x.toJson())),
    };
}

class Available {
    Available({
        this.itemId,
        this.available,
        this.itemName,
        this.requested,
    });

    String itemId;
    String available;
    String itemName;
    String requested;

    factory Available.fromJson(Map<String, dynamic> json) => Available(
        itemId: json["item_id"] == null ? null : json["item_id"],
        available: json["available"] == null ? null : json["available"],
        itemName: json["item_name"] == null ? null : json["item_name"],
        requested: json["requested"] == null ? null : json["requested"]
    );

    Map<String, dynamic> toJson() => {
        "item_id": itemId == null ? null : itemId,
        "available": available == null ? null : available,
        "item_name": itemName == null ? null : itemName,
        "requested": requested == null ? null : requested
    };
}