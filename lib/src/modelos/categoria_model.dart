// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    this.category,
  });

  List<CategoryElement> category;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    category: List<CategoryElement>.from(json["category"].map((x) => CategoryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class CategoryElement {
  CategoryElement({
    this.categoryName,
    this.hexColor,
    this.iconUrl,
  });

  String categoryName;
  String hexColor;
  String iconUrl;

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    categoryName: json["category_name"],
    hexColor: json["hex_color"],
    iconUrl: json["icon_url"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "hex_color": hexColor,
    "icon_url": iconUrl,
  };
}
