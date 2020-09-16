import 'dart:io';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class UsuarioTienditasProvider {
  Future<User> getUserInfo(String userIdToken, String userEmail) async {
    print(userEmail.toString());

    //Todo Uri builder
    String url = '$baseApiUrl/api/v1/user?email=$userEmail';

    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});

    if (200 == response.statusCode) {
      print('Dentro de user tienditas provider code 200');
      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
      print('========= Status Code inside response body:');
      print(responseTienditasApi.statusCode);
      if (responseTienditasApi.statusCode == 200) {
        final userTienditaResult = userTienditaResultFromJson(response.body);
        print('=============================================');
        User user = userTienditaResult.body.user;
        return user;
      } else {
        print('El usuario no existe en Tienditas DB');
        return null;
      }
    } else {
      print('Error user tienditas get info');
      print(response.body);
      return null;
    }
  }
}
