import 'dart:convert';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class OrderConfirmationByUser {
  Future<http.Response> confirmOrder(
      {String userIdToken, String orderId, String storeTagName}) async {
    String _url = '$baseApiUrl/api/v1/order_status';

    var bodyData = {
      "order": {
        "order_id": orderId,
        "store_tag_name": storeTagName,
        "user_confirmation": "Confirmado"
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
}

//headers: {HttpHeaders.authorizationHeader: userIdToken},
