import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<Category> getAllCategories() async {
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxODQ1OWJiYTE2NGJiN2I5MWMzMjhmODkxZjBiNTY1M2UzYjM4YmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ0MjcwNDksInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDQyNzA0OSwiZXhwIjoxNTk0NDMwNjQ5LCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.gr3jRjIKD9tjud3tmFnCgkpdXfw0oAeL-C9P_nnzAq_aKeGrXEs1q0ijbIvcYWJugNu0qppLm5hWyy_BX-NTE5doqYfbXn4VRhPw07fcliHQ3azBLCeCoj2l6o9w7ZJzIVJswHLxgjy-ZiN-V6urdhz7hH6sRY2PkwfmN9hanVeCdXvw0_a9taAtrH-ZR5ASLFVCFvKhYmscIT1iOaOfuAMS0cQzlmK0nHdFKA66B0TV09bXMkV7JAYarnPfl1Q_OD65M_ZVO-LsdKplDVSrtDHYPrFSXDCvUhG6Sy5JhRUsjoEpxO0KBre_T5PFdev1w1vzm1STqXZSGj-khwEwEA"
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
