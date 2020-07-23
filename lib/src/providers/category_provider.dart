import 'dart:io';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'file:///C:/MyAndroidStudioProjects/app_tiendita/lib/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoriesProvider {
  static const String url =
      'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/category';

  Future<CategoryModel> getAllCategories(BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final category = categoryFromJson(response.body);
      return category;
    } else {
      return CategoryModel();
    }
  }
}
