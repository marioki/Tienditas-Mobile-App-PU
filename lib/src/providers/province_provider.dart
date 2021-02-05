import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/province_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProvinceProvider {
  Future<ProvinceModel> getAllProvinces(BuildContext context) async {
    String url = '$baseApiUrl/api/v1/province';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      final provinces = provinceModelFromJson(response.body);
      return provinces;
    } else {
      return ProvinceModel();
    }
  }

  Future<http.Response> updateProvinces(BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    String _url = '$baseApiUrl/api/v1/province';
    print(_url);
    var response = await http.get(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      }
    );
    return response;
  }
}