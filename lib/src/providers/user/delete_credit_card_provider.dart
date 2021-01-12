import 'dart:convert';
import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class DeleteCreditCard {
  Future<http.Response> deleteCreditCard(UserTienditas userTienditas,
      String userIdToken, CreditCard creditCard) async {
    String userEmail = userTienditas.userEmail;
    String creditCardId = creditCard.id;
    String _url =
        '$baseApiUrl/api/v1/credit_cards?id=$creditCardId&email=$userEmail';
    var response = await http.delete(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
    );

    return response;
  }
}
