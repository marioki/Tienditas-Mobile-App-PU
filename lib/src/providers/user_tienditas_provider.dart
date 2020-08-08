import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UsuarioTienditasProvider {
  Future<UserTienditaResult> getUserInfo(BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final String userEmail = Provider.of<LoginState>(context).getUser().email;
    print(userEmail.toString());

    //Todo Uri builder
    String url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/user?email=$userEmail';

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final userTienditaResult = userTienditaResultFromJson(response.body);
      return userTienditaResult;
    } else {
      print('Error user tienditas get info');
      print(response.body);
      return null;
    }
  }
}
