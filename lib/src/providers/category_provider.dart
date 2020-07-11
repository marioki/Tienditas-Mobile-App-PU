import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<Category> getAllCategories() async {
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxODQ1OWJiYTE2NGJiN2I5MWMzMjhmODkxZjBiNTY1M2UzYjM4YmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ1MDMyNDYsInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDUwMzI0NiwiZXhwIjoxNTk0NTA2ODQ2LCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.ZWr6m4yQW1vIqGiqhvJEi711wn5Rf_HMvi2I1zqsz9RmT8pQ3kpXE7XA9kp4TUDFO7IDr_TBvu22Mjj7aSLjbOUWZxq8BqX_uFWOhVwNfu4QizqnnC62Q3bDqRGoz_l6sg3lj1ygjxRwVv7MWQU7SbpwHP77qBH02YyuA_6G6w376_uiXKJQYE2MTHrWTSXmos8ayH_xVdXOnsRjGQcFlbaR_rDWb7KX6V7SM3vDzLONvU6sJmTixnRGBYmzB2A7fKsCPr9r6HxWWx_zdUy4F3G5eF4jVa3FvUY2X9-elJxL9Qkwq_rzwFaM2Ni7Uatk3CXgHaTiwKSm2R-UNhw2Eg"
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
