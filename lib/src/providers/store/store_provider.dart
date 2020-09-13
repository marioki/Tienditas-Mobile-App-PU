import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/store/order_model.dart';
import 'package:app_tiendita/src/modelos/store/store_model.dart' as StoreModel;
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/constants/api_constants.dart';

class StoreProvider {
  Future<Tiendita> getTienditasByNameOrTag(BuildContext context, String userInput) async {
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
    final String url = '$baseApiUrl/api/v1/store_name?$userSearchParam=$userInput';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
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

  Future<StoreModel.StoreResult> getStoreInfo(BuildContext context, String storeTagName) async {
    String url = '$baseApiUrl/api/v1/store?store_tag_name=$storeTagName';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      return  StoreModel.storeResultFromJson(response.body);
    } else {
      print('Error tienditas get info');
      print(response.body);
      print(response.statusCode);
      return StoreModel.StoreResult();
    }
  }

  Future<Tiendita> getAllTienditas(BuildContext context) async {
    const String url = '$baseApiUrl/api/v1/store';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      final tiendita = tienditaFromJson(response.body);
      return tiendita;
    } else {
      return Tiendita();
    }
  }

  Future<Tiendita> getTienditasPorCategoria(String categoryName, BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final String url = '$baseApiUrl/api/v1/store?category_name=$categoryName';
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

  Future<StoreOrdersResult> getStoreBatch(BuildContext context, String storeTagName) async {
    String url = '$baseApiUrl/api/v1/order?store_tag_name=$storeTagName';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      return  storeOrderFromJson(response.body);
    } else {
      print('Error tienditas get info');
      print(response.body);
      print(response.statusCode);
      return StoreOrdersResult();
    }
  }

  Future<http.Response> newDeliveryOption(String userIdToken, String storeTagName, String name, String method, String fee) async {
    String _url = '$baseApiUrl/api/v1/update_store';
    var bodyData = {
      "store": {
        "store_tag_name": storeTagName,
        "delivery_options": {
          "name": name,
          "method": method,
          "fee": fee
        }
      }
    };
    print("====== GUARDANDO ======");
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

  Future<http.Response> editDeliveryOption(String userIdToken, String storeTagName, String id, String name, String method, String fee) async {
    String _url = '$baseApiUrl/api/v1/update_store';
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
    print("====== GUARDANDO ======");
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
