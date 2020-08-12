import 'dart:convert';
import 'dart:io';

import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DeliveryOptionsProvider {
  List<StoreDeliveryInfo> listOfDeliveryOptions = [];

  Future<List<StoreDeliveryInfo>> getStoreDeliveryOptions(
      BuildContext context, List<String> storeTagList) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    for(int i = 0; i <storeTagList.length; i++ ){
      String storeTag = storeTagList[i];
      String url =
          'https://aua4psji8k.execute-api.us-east-1.amazonaws.com/dev/api/v1/store?store_tag_name=$storeTag';

      final response = await http
          .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});

      if (200 == response.statusCode) {
        print(response.body);

        final deliveryOptionsResponse =
        deliveryOptionsResponseFromJson(response.body);
        StoreDeliveryInfo currentDeliveryOption = deliveryOptionsResponse.body.store;

        listOfDeliveryOptions.add(currentDeliveryOption);
      } else {
        print('response status code ${response.statusCode}');
        return null;
      }


    }


    print('Return de provider:');
//    print(listOfDeliveryOptions[0].toJson());
    return listOfDeliveryOptions;
  }
}
