import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class StoreOrderDetail extends StatefulWidget {
  @override
  _StoreOrderDetailState createState() => _StoreOrderDetailState();
}

class _StoreOrderDetailState extends State<StoreOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)
            ),
          ),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: azulTema,
          title: Text(
            'Detalle del Pedido',
            style: appBarStyle,
          ),
        )
    );
  }
}
