import 'dart:io';
import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/constants/api_constants.dart';

class UserCreditCardProvider {
  List<CreditCard> listCreditCards = [];

  Future<List<CreditCard>> getUserCreditCards(BuildContext context, email) async {
    String url = '$baseApiUrl/api/v1/credit_cards?email=$email';
    final userIdToken = Provider.of<LoginState>(context, listen: false).currentUserIdToken;

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final creditCardResult = creditCardResultFromJson(response.body);
      listCreditCards = creditCardResult.body.user.creditCards;
      return listCreditCards;
    } else {
      return List();
    }
  }
}
