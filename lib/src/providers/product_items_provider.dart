import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/utils/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductProvider {
  //Todo Traer productos por store usando uri constructor

  Future<Product> getStoreProducts(String storeTagName, BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final url = '$apiBaseUrl/api/v1/product?store_tag_name=$storeTagName';


    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final product = productFromJson(response.body);
      return product;
    } else {
      return Product();
    }
  }
}
