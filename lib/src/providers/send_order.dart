import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class SendBatchOfOrders {
  Future<http.Response> sendBatchOfOrders(UserTienditas userTienditas,
      String userIdToken, Batch currentBatch) async {
    String _url = '$baseApiUrl/api/v1/order';
    //Final batch set info
    var _batchBody = currentBatch.toJson();
    var jsonBody = jsonEncode(_batchBody);
    print(_batchBody);
    print(jsonBody);

    var response = await http.post(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: userIdToken,
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonBody,
    );
    print(response.body);

    return response;
  }
}

//headers: {HttpHeaders.authorizationHeader: userIdToken},
