import 'dart:convert';
import 'dart:io';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/constants/api_constants.dart';

class ProductProvider {
  //Todo Traer productos por store usando uri constructor

  Future<Product> getStoreProducts(
      String storeTagName, BuildContext context) async {
    final userIdToken = Provider.of<LoginState>(context).currentUserIdToken;

    final url = '$apiBaseUrl/api/v1/product?store_tag_name=$storeTagName';

    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: userIdToken});
    if (200 == response.statusCode) {
      print(response.body);

      final product = productFromJson(response.body);
      return product;
    } else {
      return Product();
    }
  }

  Future<http.Response> updateProduct(
      String userIdToken, ProductElement productElement) async {
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": productElement.storeTagName,
        "item_id": productElement.itemId,
        "base_price": productElement.basePrice,
        "final_price": productElement.finalPrice,
        "item_name": productElement.itemName,
        "quantity": productElement.quantity
      }
    };
    String _body = jsonEncode(bodyData);
    var response = await http.put(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userIdToken
      },
      body: _body,
    );
    return response;
  }

  Future<http.Response> createProductWithImage({String userIdToken, itemName, finalPrice,
      basePrice, quantity, storeTagName, itemImage}) async {
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": storeTagName,
        "base_price": basePrice,
        "final_price": finalPrice,
        "image": itemImage,
        "item_name": itemName,
        "item_status": "entrega inmediata",
        "quantity": quantity
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
    return response;
  }

  Future<http.Response> createProduct({String userIdToken, itemName, finalPrice,
      basePrice, quantity, storeTagName}) async {
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": storeTagName,
        "base_price": basePrice,
        "final_price": finalPrice,
        "item_name": itemName,
        "item_status": "entrega inmediata",
        "quantity": quantity
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
    return response;
  }

}
