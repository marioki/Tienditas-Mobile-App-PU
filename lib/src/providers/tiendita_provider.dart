import 'dart:io';

import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:http/http.dart' as http;

class TienditasProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store';

  Future<Tiendita> getAllTienditas() async {
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxODQ1OWJiYTE2NGJiN2I5MWMzMjhmODkxZjBiNTY1M2UzYjM4YmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ1MDY2OTQsInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDUwNjY5NCwiZXhwIjoxNTk0NTEwMjk0LCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.KBXcJG7SVoZ-5IWHJWVeXwCmF5LDMCXj9CX_0lYRk-zu04e84rWJSFMvlk--kfUP9aakPoWE4BJ0haJb9ADoHOAdTU1QluOo2umvgDOSfEX7OzsK1MWqvi_n4ryno1Cv0DGzXQ5I26PEPk7jyiVmQ3l99R_LtHNC2rxmRl38_AEc78pLWxetZORt1jvYXcDQ37XYpc5_QGaX0BzNzhXo_e8e78CWwCBRrYcDwBvcg86LC85PfR1kMvt3KQ3aFsQHaO8y1xLKkzru4GcXk1FmcLbn4Cui6LyfoSs-t4QjmeRI9dYZU-GzKDav_4c90OWzSqk0tLc_-IDE6SEqYyviBA"
    });
    if (200 == response.statusCode) {
      print(response.body);

      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }
}
