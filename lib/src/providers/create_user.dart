import 'dart:convert';
import 'dart:io';

import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CreateTienditaUser {
  Future<http.Response> createUserTienditas(
      FirebaseUser firebaseUser, String userIdToken) async {
    String _url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/user';
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
