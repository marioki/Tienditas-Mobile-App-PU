import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class ResumenDeCompra extends StatefulWidget {
  @override
  _ResumenDeCompraState createState() => _ResumenDeCompraState();
}

class _ResumenDeCompraState extends State<ResumenDeCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grisClaroTema,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Resumen',
            style: appBarStyle,
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                'SIGUIENTE',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              color: azulTema,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
            ),
          ],
        ),
      ),
    );
  }
}
