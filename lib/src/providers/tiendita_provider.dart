import 'dart:io';

import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//Todo Usar URI constructor para tener nu solo tienditas provider para todos los calls

class TienditasProvider  {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store';
  Future<Tiendita> getAllTienditas(BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }
}
