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

class Tienda {
  final String name;
  final String handle;
  final int followers;
  final String image;
  final String category;

  Tienda({this.name, this.handle, this.followers, this.image, this.category});

  factory Tienda.fromJsonMap(Map<String, dynamic> json) {
    return Tienda(
      name: json['name'],
      handle: json['handle'],
      followers: json['followers'],
      image: json['image'],
      category: json['category'],
    );
  }
}
