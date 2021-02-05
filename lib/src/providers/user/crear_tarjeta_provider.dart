import 'dart:convert';
import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class CreateNewCreditCard {
  Future<http.Response> sendNewCreditCard(UserTienditas tienditasUser,
      String userIdToken, CreditCard newCard) async {
    String _url = '$baseApiUrl/api/v1/credit_cards';
    String userEmail = tienditasUser.userEmail;

    var bodyData = {
      "user": {
        "email": userEmail,
        "credit_card": {
          "number": newCard.number,
          "expiration_date": newCard.expirationDate,
          "cvv": newCard.cvv,
          "holder_name": newCard.holderName
        }
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
