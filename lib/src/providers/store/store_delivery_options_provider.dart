import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DeliveryOptionsProvider {
  List<StoreDeliveryInfo> listOfStoreDeliveryInfo = [];

  Future<List<StoreDeliveryInfo>> getStoresDeliveryInfo(
      BuildContext context, List<String> storeTagList) async {
    final userIdToken = Provider.of<LoginState>(context, listen: false).currentUserIdToken;

    for (int i = 0; i < storeTagList.length; i++) {
      String storeTag = storeTagList[i];
      String url = '$baseApiUrl/api/v1/store?store_tag_name=$storeTag';
      final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
      if (200 == response.statusCode) {
        print(response.body);
        final deliveryOptionsResponse =
        deliveryOptionsResponseFromJson(response.body);
        StoreDeliveryInfo currentDeliveryOption = deliveryOptionsResponse.body.store;
        listOfStoreDeliveryInfo.add(currentDeliveryOption);
      } else {
        print('response status code ${response.statusCode}');
        return null;
      }
    }

    print('Return de provider:');
    return listOfStoreDeliveryInfo;
  }
}