import 'dart:convert';

import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SendBatchOfOrders {
  Future<http.Response> sendBatchOfOrders(
      FirebaseUser firebaseUser, String userIdToken, Batch currentBatch) async {
    String _url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/order';
    String userEmail = firebaseUser.email;
    String userName = firebaseUser.displayName;

    var _batchBody = currentBatch.toJson();

    var bodyData = {
      "user": {
        "email": userEmail,
        "first_name": userName,
        "last_name": 'apellidoAqui',
        "address": [],
        "credit_card": [],
        "preferences": []
      }
    };

    String _body = jsonEncode(bodyData);

    var response = await http.post(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: _batchBody,
    );
    print(response.body);

    return response;
  }
}

//headers: {HttpHeaders.authorizationHeader: userIdToken},
