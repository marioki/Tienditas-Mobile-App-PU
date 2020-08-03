import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class DeliveryOptionsPage extends StatelessWidget {
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
              'Delivery',
              style: appBarStyle,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'Escoge la opción de envío para tus pedidos...',
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                getDeliveryOptionsWidget(),
                getDeliveryOptionsWidget(),
                getDeliveryOptionsWidget(),
              ],
            )
          ],
        ),
        bottomSheet: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'COSTO DE ENVÍO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: grizSubtitulo,
                    ),
                  ),
                  Text(
                    '\$100.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: azulTema,
                    ),
                  ),
                ],
              ),
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
        ));
  }

  Widget getDeliveryOptionsWidget() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {  },
        child: ListTile(
          title: Row(
            children: <Widget>[
              Text('Pedido a My Loop Bands'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '\$2.50',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.more_horiz),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }
}
