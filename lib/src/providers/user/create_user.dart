import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class CreateTienditaUser {
  Future<http.Response> createUserTienditas(
      FirebaseUser firebaseUser, String userIdToken) async {
    String _url = '$baseApiUrl/api/v1/user';
    String userEmail = firebaseUser.email;
    String userName = firebaseUser.displayName;

    var bodyData = {
      "user": {
        "email": userEmail,
        "name": userName,
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
      body: _body,
    );
    print(response.body);

    return response;
  }
}

//headers: {HttpHeaders.authorizationHeader: userIdToken},
