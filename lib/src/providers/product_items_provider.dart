import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  //Todo Traer productos por store usando uri constructor

  Future<Product> getStoreProducts(storeTagName) async {
    final url = '$apiBaseUrl/api/v1/product?store_tag_name=$storeTagName';

    // var queryParameters = {'store_tag_name': '@asus'};
    // uri = Uri.https(apiBaseUrl, 'api/v1/product', queryParameters);

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
