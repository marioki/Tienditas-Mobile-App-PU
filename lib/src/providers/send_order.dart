import 'dart:convert';
import 'dart:io';

import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SendBatchOfOrders {
  Future<http.Response> sendBatchOfOrders(
      FirebaseUser firebaseUser, String userIdToken, Batch currentBatch) async {
    String _url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/order';
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
