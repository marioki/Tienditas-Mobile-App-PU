import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<Category> getAllCategories() async {

    Future<http.Response> fetchUserTokenId() {
      return http.get('https://jsonplaceholder.typicode.com/albums/1');
    }

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
      constantDebugUserTokenId
    });
    if (200 == response.statusCode) {
      print(response.body);

      final category = categoryFromJson(response.body);
      return category;
    } else {
      return Category();
    }
  }
}
