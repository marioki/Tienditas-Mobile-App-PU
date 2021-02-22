import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/availability_model.dart';
import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:http/http.dart' as http;
import 'package:app_tiendita/src/constants/api_constants.dart';

class SendBatchOfOrders {
  Future<http.Response> sendBatchOfOrders(UserTienditas userTienditas,
      String userIdToken, Batch currentBatch) async {
    String _url = '$baseApiUrl/api/v1/order';
    //Final batch set info
    var _batchBody = currentBatch.toJson();
    var jsonBody = jsonEncode(_batchBody);
    var response = await http.post(
      _url,
      headers: {
        HttpHeaders.authorizationHeader: userIdToken,
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonBody,
    );
    print(response.body);

    return response;
  }

  Future<AvailabilityResponse> checkInventoryAvailability(UserTienditas userTienditas,
      String userIdToken, Batch currentBatch) async {
    String _url = '$baseApiUrl/api/v1/inventory/availability';
    var jsonBody = jsonEncode(currentBatch.toJson());
    var response = await http.post(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: jsonBody,
    );
    if (200 == response.statusCode) {
      print("EN EL SEND ORDER");
      print(response.body);
      return availabilityFromJson(response.body);
    } else {
      print(response.body);
      print(response.statusCode);
      return AvailabilityResponse();
    }
  }
}
