import 'dart:io';
import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/constants/api_constants.dart';

class CategoriesProvider {
  Future<CategoryResponseModel> getAllCategories(BuildContext context) async {
    String url = '$baseApiUrl/api/v1/category';
    final userIdToken = Provider.of<LoginState>(context, listen: false).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      final category = categoryFromJson(response.body);
      return category;
    } else {
      return CategoryResponseModel();
    }
  }
}
