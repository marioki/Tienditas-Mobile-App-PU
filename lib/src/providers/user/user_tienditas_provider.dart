import 'dart:convert';
import 'dart:io';
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

  Future<http.Response> updateUser(
      String userIdToken, User user) async {
    String _url = '$baseApiUrl/api/v1/user';
    var bodyData = {
      "user": {
        "email": user.userEmail,
        "phone_number": user.phoneNumber,
        "preferences": user.preferences
      }
    };
    print(bodyData);
    String _body = jsonEncode(bodyData);
    var response = await http.put(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: _body,
    );
    return response;
  }

  Future<http.Response> createAddress(
      String userIdToken,
      String userEmail,
      String name,
      String addressLine1,
      String referencePoint,
      String country,
      String province) async {
    String _url = '$baseApiUrl/api/v1/address';
    var bodyData = {
      "user": {
        "email": userEmail,
        "address": {
          "name": name,
          "address_line_1": addressLine1,
          "reference_point": referencePoint,
          "country": country,
          "province": province
        }
      }
    };
    print(bodyData);
    String _body = jsonEncode(bodyData);
    var response = await http.post(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: _body,
    );
    return response;
  }

  Future<http.Response> updateAddress(
      String userIdToken,
      String id,
      String userEmail,
      String name,
      String addressLine1,
      String referencePoint,
      String country,
      String province) async {
    String _url = '$baseApiUrl/api/v1/address';
    var bodyData = {
      "user": {
        "email": userEmail,
        "address": {
          "id": id,
          "name": name,
          "address_line_1": addressLine1,
          "reference_point": referencePoint,
          "country": country,
          "province": province
        }
      }
    };
    print(bodyData);
    String _body = jsonEncode(bodyData);
    var response = await http.put(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: _body,
    );
    return response;
  }
}
