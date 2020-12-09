import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/questions.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class InfoProvider{
  Future<List<Question>> getAllQuestions(BuildContext context) async {
    List<Question> listQuestions = [];

    String url = '$baseApiUrl/api/v1/catalog';
   // final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "xxx"});
    if(200 == response.statusCode) {
      final questions = questionsFromJson(response.body);
      listQuestions = questions.body.questions;
      return listQuestions;
    } else {
      return listQuestions;
    }
  }
}