import 'dart:io';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
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

  Future<Tiendita> getStoreInfo(BuildContext context, String storeTagName) async {
    String url = '$baseApiUrl/api/v1/store?store_tag_name=$storeTagName';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      return tienditaFromJson(response.body);
    } else {
      print('Error tienditas get info');
      print(response.body);
      print(response.statusCode);
      return Tiendita();
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
}
