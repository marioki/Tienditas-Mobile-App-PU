import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/banks_model.dart';
import 'package:app_tiendita/src/modelos/province_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BankProvider {
  Future<BanksModel> getAllBanks(BuildContext context) async {
    String url = '$baseApiUrl/api/v1/bank';
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);
      final banks = banksModelFromJson(response.body);
      return banks;
    } else {
      return BanksModel();
    }
  }
}