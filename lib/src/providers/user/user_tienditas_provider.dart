import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/user/user_order_batch.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class UsuarioTienditasProvider {
  Future<UserTienditas> getUserInfo(String userIdToken, String userEmail) async {
    String url = '$baseApiUrl/api/v1/user?email=$userEmail';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        final userTienditaResult = userTienditaResultFromJson(response.body);
        UserTienditas user = userTienditaResult.body.user;
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
      String userIdToken, UserTienditas user) async {
    String _url = '$baseApiUrl/api/v1/user';
    var bodyData = {
      "user": {
        "name": user.name,
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
      String province,
      String latitude,
      String longitude,
      String phoneNumber) async {
    String _url = '$baseApiUrl/api/v1/address';
    var bodyData = {
      "user": {
        "email": userEmail,
        "address": {
          "name": name,
          "address_line_1": addressLine1,
          "reference_point": referencePoint,
          "country": country,
          "province": province,
          "latitude": latitude,
          "longitude": longitude,
          "phone_number": phoneNumber
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
      String province,
      String latitude,
      String longitude,
      String phoneNumber) async {
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
          "province": province,
          "latitude": latitude,
          "longitude": longitude,
          "phone_number": phoneNumber
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

  Future<http.Response> deleteAddress(
      String userIdToken,
      String id,
      String userEmail) async {
    String _url = '$baseApiUrl/api/v1/address?email=$userEmail&id=$id';
    var response = await http.delete(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      }
    );
    return response;
  }

  Future<http.Response> createBankAccount(
      String userIdToken,
      String userEmail,
      String bankName,
      String number,
      String type) async {
    String _url = '$baseApiUrl/api/v1/bank_account';
    var bodyData = {
      "user": {
        "email": userEmail,
        "bank_account": {
          "bank_name": bankName,
          "account_number": number,
          "account_type": type
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

  Future<http.Response> updateBankAccount(
      String userIdToken,
      String userEmail,
      String bankName,
      String number,
      String id,
      bool isDefault,
      String type) async {
    String _url = '$baseApiUrl/api/v1/bank_account';
    var bodyData = {
      "user": {
        "email": userEmail,
        "bank_account": {
          "bank_name": bankName,
          "account_number": number,
          "account_type": type,
          "id": id,
          "is_default": isDefault
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

  Future<http.Response> deleteBankAccount(String email,
      String userIdToken, BankAccount bankAccount) async {
    String bankAccountId = bankAccount.id;
    String _url =
        '$baseApiUrl/api/v1/bank_account?id=$bankAccountId&email=$email';
    var response = await http.delete(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
    );

    return response;
  }

  Future<http.Response> sendSuggestion(
      String userIdToken,
      String userEmail,
      String suggestion) async {
    String _url = '$baseApiUrl/api/v1/suggestion';
    var bodyData = {
      "suggestion": {
        "email": userEmail,
        "suggestion": suggestion
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


}
