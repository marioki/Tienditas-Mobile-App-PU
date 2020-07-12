import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<Category> getAllCategories() async {
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxODQ1OWJiYTE2NGJiN2I5MWMzMjhmODkxZjBiNTY1M2UzYjM4YmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ1MTU4MDMsInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDUxNTgwMywiZXhwIjoxNTk0NTE5NDAzLCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.KlkjhXFR63wtV6S8w5YPBYhumIlLCLfWwyeBjNwIdfJPbyjrdMXIJGFBjguB5e_TPEyJ4BkK8kVZ5j8J1MRlneWNsMKsloXyMXllskqAjyH_q6YBBSkSQzo4EWkX2bRJ0jJRkRlk7yykkJ1mD2bFEDWyH5srfMjCBP7UcSgUysnZ1TBuoqupmtAGQO4zIo-FIw2drSuUw8fQSx8owI-EShWVMBujChhYz4P0aoYyC1jnuQLZd-pqW9DwMuazzj-ciDD25BdN6eEUTDkz0O09Xeg_tZ3eg7Yx2kYAR-4UEdpD3ClgJfiKwtV3emWD5bFt_iwSLvlyLEp4Q9DpM3_t-A"
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
