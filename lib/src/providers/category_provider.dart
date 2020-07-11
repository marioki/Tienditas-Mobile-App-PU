import 'dart:convert';
import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<Category> getAllCategories() async {
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxODQ1OWJiYTE2NGJiN2I5MWMzMjhmODkxZjBiNTY1M2UzYjM4YmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ0MjIyMDYsInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDQyMjIwNiwiZXhwIjoxNTk0NDI1ODA2LCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.fkFVO__OcAyj8U6OZN7XodKMQtrGqTPBulUbSGifZ9P2IMP5j6RvAswnUXr3-oX3pidNCzWA9DkagLBIVtVrDhvOu2yxJlPgcd5PjC9rnvcGlOgj9CwvGa0yfJ16kXYJhDKDrUcbIcGRGz8I0aLSnXM7pzGSbXJgQHN93x94PLXmbfss3PlanoDJ-X9mLnfpnseCQve1aE4O2_ojcHLea4PeOK-RQxOKOhqmQPLrEkJqaM_sJuQQ_NBf1zPXfc3_KDQsJMKykBPuV7-XRj4Ov2QdHK-xzf_vfrsJGf1rPDsRzv9fwLqoRNuhx53Aloijf1CGAcq3zgclRHnkz7mfyQ"
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
