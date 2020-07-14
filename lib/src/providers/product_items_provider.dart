import 'dart:io';

import 'package:app_tiendita/src/constants/UserTokenId.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  //Todo Construir url con http.URI
  //Todo Traer productos por store

  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/product?store_tag_name=@asus';


  Future<Product> getStoreProducts() async {
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: constantDebugUserTokenId});
    if (200 == response.statusCode) {
      print(response.body);

      final product = productFromJson(response.body);
      return product;
    } else {
      return Product();
    }
  }
}
