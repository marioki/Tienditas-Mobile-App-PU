import 'dart:convert';
import 'dart:io';

import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DeliveryOptionsProvider {
  List<DeliveryOption> listOfDeliveryOptions;

  Future<DeliveryOptionsResponse> getStoreDeliveryOptions(
      BuildContext context, String storeTag) async {
    String url =
        'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store?store_tag_name=$storeTag';

    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final deliveryOptionsResponse =
          deliveryOptionsResponseFromJson(response.body);

      listOfDeliveryOptions =
          deliveryOptionsResponse.body.store.deliveryOptions;
      //return listOfDeliveryOptions;
      return deliveryOptionsResponse;
    } else {
      return null;
    }
  }
}
