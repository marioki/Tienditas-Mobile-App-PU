import 'dart:io';
import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/user/user_order_batch.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class UsuarioTienditasProvider {
  Future<User> getUserInfo(String userIdToken, String userEmail) async {
    String url = '$baseApiUrl/api/v1/user?email=$userEmail';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        final userTienditaResult = userTienditaResultFromJson(response.body);
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

  Future<UserOrderBatchModel> getUserOrders(String userIdToken, String email) async {
    final response = await http.get(
        '$baseApiUrl/api/v1/order?email=$email',
        headers: {HttpHeaders.authorizationHeader: userIdToken}
        );
    if (200 == response.statusCode) {
      print(response.body);
      return  userBatchFromJson(response.body);
    } else {
      print('Error order batch get info');
      print(response.body);
      print(response.statusCode);
      return UserOrderBatchModel();
    }
  }
}
