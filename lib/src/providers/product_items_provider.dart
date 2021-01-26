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
    final userIdToken = Provider.of<LoginState>(context, listen: false).currentUserIdToken;

    final url = '$baseApiUrl/api/v1/product?store_tag_name=$storeTagName';

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

  Future<http.Response> updateProduct({
    String userIdToken,
    ProductElement productElement,
    String deliveryTime,
  }) async {
    print('=========Updatr Product Method============');
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": productElement.storeTagName,
        "item_id": productElement.itemId,
        "final_price": productElement.finalPrice,
        "item_name": productElement.itemName,
        "quantity": productElement.quantity,
        "delivery_time": deliveryTime,
        "discount_price": productElement.discountPrice,
        "description": productElement.description
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


  Future<http.Response> updateProductAdd(
      {String userIdToken,
        ProductElement productElement,
        List<String> itemImageBase64List,
        String deliveryTime,
        List<String> imagesUrl}) async {
    print('=========Updatr Product with Image Method============');
    print(imagesUrl);
    print('=================================');
    print(itemImageBase64List);
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": productElement.storeTagName,
        "item_id": productElement.itemId,
        "final_price": productElement.finalPrice,
        "images": itemImageBase64List,
        "item_name": productElement.itemName,
        "quantity": productElement.quantity,
        "delivery_time": deliveryTime,
        "discount_price": productElement.discountPrice,
        "description": productElement.description,
        "variants": productElement.variants
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



  Future<http.Response> updateProductDeleteAndAdd(
      {String userIdToken,
      ProductElement productElement,
      List<String> itemImageBase64List,
      String deliveryTime,
      List<String> imagesUrl}) async {
    print('=========Updatr Product with Image Method============');
    print(imagesUrl);
    print('=================================');
    print(itemImageBase64List);
    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": productElement.storeTagName,
        "item_id": productElement.itemId,
        "final_price": productElement.finalPrice,
        "images": itemImageBase64List,
        "images_url": imagesUrl,
        "item_name": productElement.itemName,
        "quantity": productElement.quantity,
        "delivery_time": deliveryTime,
        "discount_price": productElement.discountPrice,
        "description": productElement.description,
        "variants": productElement.variants
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

  Future<http.Response> createProductWithImage(
      {String userIdToken,
      itemName,
      description,
      finalPrice,
      quantity,
      storeTagName,
      var itemImageUrlList,
      String deliveryTime,
      variants}) async {
    print('=========Create Product with image Method============');
    var images = jsonEncode(itemImageUrlList);

    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": storeTagName,
        "final_price": finalPrice,
        'discount_price': "0.00",
        "images": itemImageUrlList,
        "item_name": itemName,
        "description": description,
        "item_status": "active",
        "quantity": quantity,
        "delivery_time": deliveryTime,
        "variants": variants
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

  Future<http.Response> createProduct({
    String userIdToken,
    itemName,
    description,
    finalPrice,
    quantity,
    storeTagName,
    String deliveryTime,
    variants
  }) async {
    print('=========Create Product Method============');

    String _url = '$baseApiUrl/api/v1/product';
    var bodyData = {
      "product": {
        "store_tag_name": storeTagName,
        "final_price": finalPrice,
        'discount_price': "0.00",
        "item_name": itemName,
        "description": description,
        "item_status": "active",
        "quantity": quantity,
        "delivery_time": deliveryTime,
        "variants": variants
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
