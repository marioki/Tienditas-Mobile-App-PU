import 'package:app_tiendita/src/modelos/product_model.dart';

class Tienda {
  String name;
  String handle;
  int followers;
  String image;
  String category;
  var storeItemList = List();
  List<Product> storeProductList;

  Tienda(
      {this.name,
      this.handle,
      this.followers,
      this.image,
      this.category,
      this.storeProductList,
      this.storeItemList});

  factory Tienda.fromJsonMap(Map<String, dynamic> json) {
    return Tienda(
      name: json['name'],
      handle: json['handle'],
      followers: json['followers'],
      image: json['image'],
      category: json['category'],
      storeItemList: json['store_items'],
    );
  }
}

class TiendaList {
  List<Tienda> items = List();

  TiendaList();

  TiendaList.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final tienda = Tienda.fromJsonMap(item);
      items.add(tienda);
    }
  }
}
