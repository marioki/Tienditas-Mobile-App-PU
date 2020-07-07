import 'dart:convert';

import 'package:app_tiendita/src/modelos/store_model.dart';
import 'package:http/http.dart' as http;

class TiendasProvider {
  Future<List<Tienda>> getAllTiendas() async {
    var result = await http
        .get('http://5f04bfae8b06d60016ddeff0.mockapi.io/api/v1/tiendas');
    final decodedData = json.decode(result.body);

    final tiendas = TiendaList.fromJsonList(decodedData['tiendas']);
    return tiendas.items;
  }
}
