

class Product {
  String title;
  String image;
  String description;
  double price;

  Product({
    this.image,
    this.title,
    this.price,
    this.description,
  });

  Product.fromJson(Map<String, dynamic> jsonMap) {
    this.title = jsonMap['title'];
    this.image = jsonMap['image'];
    this.description = jsonMap['description'];
    this.price = double.parse(jsonMap['price']);
  }
}
