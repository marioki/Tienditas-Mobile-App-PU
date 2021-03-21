import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class CrearNuevaDireccion extends StatefulWidget {
  @override
  _CrearNuevaDireccionState createState() => _CrearNuevaDireccionState();
}

class _CrearNuevaDireccionState extends State<CrearNuevaDireccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grisClaroTema,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        centerTitle: true,
        backgroundColor: azulTema,
        title: Text(
          'Dirección',
          style: appBarStyle,
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Guardar',
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(fontFamily: 'Nunito'),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Calle 1',
                labelStyle: TextStyle(fontFamily: 'Nunito'),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Calle 2',
                labelStyle: TextStyle(fontFamily: 'Nunito'),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Punto de Referencia',
                labelStyle: TextStyle(fontFamily: 'Nunito'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
