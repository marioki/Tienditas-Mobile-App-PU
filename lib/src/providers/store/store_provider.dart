import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/store/order_model.dart';
import 'package:app_tiendita/src/modelos/store/store_model.dart' as StoreModel;
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/constants/api_constants.dart';

class StoreProvider {
  int rowCount = 10;

  Future<Tiendita> getTienditasByNameOrTag(
      BuildContext context, String userInput) async {
    String userSearchParam;
    String formattedUserInput;
    if (userInput.isNotEmpty) {
      if (userInput.startsWith('@')) {
        print('User Input: $userInput');
        userSearchParam = 'store_tag_name';
      } else {
        userSearchParam = 'store_name';
        formattedUserInput = userInput;
      }
    } else {
      return null;
    }
    final String url =
        '$baseApiUrl/api/v1/store_name?$userSearchParam=$userInput';
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

  Future<StoreModel.StoreModel> getStoreInfo(
      BuildContext context, String storeTagName) async {
    String url = '$baseApiUrl/api/v1/store?store_tag_name=$storeTagName';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      return StoreModel.storeResultFromJson(response.body);
    } else {
      print('Error tienditas get info');
      print(response.body);
      print(response.statusCode);
      return StoreModel.StoreModel();
    }
  }

  Future<Tiendita> getAllTienditas(BuildContext context) async {
    String url = '$baseApiUrl/api/v1/store?row_count=$rowCount';
    final userIdToken =
        Provider.of<LoginState>(context, listen: false).currentUserIdToken;
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }

  Future<Tiendita> getTienditasPorCategoria(
      String categoryName, BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final String url = '$baseApiUrl/api/v1/store?category_name=$categoryName';
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }

  Future<StoreOrdersResult> getStoreOrders(
      BuildContext context, String storeTagName) async {
    String url = '$baseApiUrl/api/v1/order?store_tag_name=$storeTagName';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      return storeOrderFromJson(response.body);
    } else {
      print('Error tienditas get info');
      print(response.body);
      print(response.statusCode);
      return StoreOrdersResult();
    }
  }

  Future<http.Response> newDeliveryOption(String userIdToken,
      String storeTagName, String name, String method, String fee) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "delivery_options": {"name": name, "method": method, "fee": fee}
      }
    };
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

  Future<http.Response> editDeliveryOption(
      String userIdToken,
      String storeTagName,
      String id,
      String name,
      String method,
      String fee) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "delivery_options": {
          "id": id,
          "name": name,
          "method": method,
          "fee": fee
        }
      }
    };
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

  Future<http.Response> updateOrderStatus(String userIdToken,
      String storeTagName, String orderId, String status) async {
    String _url = '$baseApiUrl/api/v1/order_status';
    print(_url);
    var bodyData = {
      "order": {
        "store_tag_name": storeTagName,
        "order_id": orderId,
        "status": status
      }
    };
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

  Future<http.Response> createStoreWithLogo(
      String userIdToken,
      String storeTagName,
      String storeName,
      String provinceName,
      String categoryName,
      String description,
      String phoneNumber,
      String userEmail,
      String base64Icon) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "store_name": storeName,
        "province_name": provinceName,
        "category_name": categoryName,
        "description": description,
        "phone_number": phoneNumber,
        "user_email": userEmail,
        "icon": base64Icon,
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

  Future<http.Response> createStore(
    String userIdToken,
    String storeTagName,
    String storeName,
    String provinceName,
    String categoryName,
    String description,
    String phoneNumber,
    String userEmail,
  ) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "store_name": storeName,
        "province_name": provinceName,
        "category_name": categoryName,
        "description": description,
        "phone_number": phoneNumber,
        "user_email": userEmail
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

  Future<http.Response> updateStore(
      String userIdToken,
      String storeTagName,
      String storeName,
      String provinceName,
      String categoryName,
      String description,
      String phoneNumber) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "store_name": storeName,
        "province_name": provinceName,
        "category_name": categoryName,
        "description": description,
        "phone_number": phoneNumber
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


//Actualizar Store con imagen
  Future<http.Response> updateStoreWithImage(
      String userIdToken,
      String storeTagName,
      String storeName,
      String provinceName,
      String categoryName,
      String description,
      String phoneNumber,
      String base64Image) async {
    String _url = '$baseApiUrl/api/v1/store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "store_name": storeName,
        "province_name": provinceName,
        "category_name": categoryName,
        "description": description,
        "phone_number": phoneNumber,
        "icon": base64Image
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
