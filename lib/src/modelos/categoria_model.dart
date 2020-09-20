import 'dart:convert';

CategoryResponseModel categoryFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  CategoryResponseModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
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
    this.categoryList,
  });

  List<CategoryElement> categoryList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    categoryList: List<CategoryElement>.from(json["category"].map((x) => CategoryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(categoryList.map((x) => x.toJson())),
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
