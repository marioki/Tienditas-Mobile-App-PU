import 'dart:io';

import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//Todo Usar URI constructor para tener nu solo tienditas provider para todos los calls

class BuscarTienditasProvider {
  Future<Tiendita> getTienditasByNameOrTag(BuildContext context, String userInput) async {
    String userSearchParam;
    String formattedUserInput;

    if (userInput.isNotEmpty){
      if (userInput.startsWith('@')) {
        print('User Input: $userInput');
        formattedUserInput = userInput.replaceFirst('@', '');
        print('User Input modified: $formattedUserInput');
        userSearchParam = 'store_tag_name';
      } else {
        userSearchParam = 'store_name';
        formattedUserInput = userInput;
      }

    }else{
      return null;
    }





    final String url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store_name?$userSearchParam=$formattedUserInput';

    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      print(response.body);
      print(response.statusCode);
      return Tiendita();
    }
  }
}
