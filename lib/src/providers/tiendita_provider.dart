import 'dart:io';

import 'package:app_tiendita/src/constants/UserTokenId.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:http/http.dart' as http;

class TienditasProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store';

  Future<Tiendita> getAllTienditas() async {
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: constantDebugUserTokenId});
    if (200 == response.statusCode) {
      print(response.body);

      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }
}
