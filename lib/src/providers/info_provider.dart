import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/faqs_response_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class InfoProvider {
  Future<FaqsResponseModel> getFaqs(BuildContext context) async {
    String url = '$baseApiUrl/api/v1/catalog';
    final userIdToken = Provider
        .of<LoginState>(context, listen: false)
        .currentUserIdToken;
    final response = await http.get(
        url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      final faqsResponseModel = faqsResponseModelFromJson(response.body);
      return faqsResponseModel;
    } else {
      return FaqsResponseModel();
    }
  }
}