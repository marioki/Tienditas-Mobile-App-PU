import 'package:app_tiendita/src/pages/checkout_sequence/editar_direccion.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class EscogerDirecciones extends StatefulWidget {
  @override
  _EscogerDireccionesState createState() => _EscogerDireccionesState();
}

class _EscogerDireccionesState extends State<EscogerDirecciones> {
  int groupRadio = 1;

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
                  bottomRight: Radius.circular(35))),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Dirección',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarDireccion(),
                  ),
                );
              },
              color: azulTema,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            _getDireccionCard(
                context, 1, 'Mi Chantín', 'Entrega por las Cumbres'),
            SizedBox(height: 4),
            _getDireccionCard(
                context, 2, 'Donde mi Novia', 'Entrega por las Cumbres'),
          ],
        ),
      ),
    );
  }

  _getDireccionCard(
      BuildContext context, int index, String title, String subtitle) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {},
        child: ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          trailing: Radio(
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                groupRadio = value;
                print(groupRadio);
              });
            },
            groupValue: groupRadio,
            value: index,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }
}
