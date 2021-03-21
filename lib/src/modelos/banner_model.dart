import 'dart:convert';

BannerResponseModel bannerFromJson(String str) =>
    BannerResponseModel.fromJson(json.decode(str));

String bannerToJson(BannerResponseModel data) => json.encode(data.toJson());

class BannerResponseModel {
  BannerResponseModel({
    this.statusCode,
    this.body,
  });

  int statusCode;
  Body body;

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
      BannerResponseModel(
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
    this.bannerList,
  });

  List<BannerElement> bannerList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        bannerList: List<BannerElement>.from(
            json["banner"].map((x) => BannerElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": List<dynamic>.from(bannerList.map((x) => x.toJson())),
      };
}

class BannerElement {
  BannerElement({
    this.link,
    this.description,
    this.title,
    this.imageUrl,
  });

  String link;
  String description;
  String title;
  String imageUrl;

  factory BannerElement.fromJson(Map<String, dynamic> json) => BannerElement(
        link: json["link"],
        description: json["description"],
        title: json["title"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "description": description,
        "title": title,
        "image_url": imageUrl,
      };
}
