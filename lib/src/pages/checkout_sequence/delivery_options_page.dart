import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/providers/store_delivery_options_provider.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/alert_dialogs/delivery_alert_dialog.dart';
import 'package:flutter/material.dart';

class DeliveryOptionsPage extends StatefulWidget {
  @override
  _DeliveryOptionsPageState createState() => _DeliveryOptionsPageState();
}

class _DeliveryOptionsPageState extends State<DeliveryOptionsPage> {
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
      body: FutureBuilder(
        //Todo el metodo de getStoreDeliveryOptions retorne una lista de listas
        future: DeliveryOptionsProvider()
            .getStoreDeliveryOptions(context, '@razer'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DeliveryOptionsResponse deliveryOptionsResponse =
                      snapshot.data;
                  StoreDelliveryInfo storeDelliveryInfo =
                      deliveryOptionsResponse.body.store;
                  return ListTile(
                    title: Text(storeDelliveryInfo.deliveryOptions[0].name),
                  );
                });
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      //      bottomSheet: Container(
//        padding: EdgeInsets.all(16),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  'COSTO DE ENVÍO',
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    color: grizSubtitulo,
//                  ),
//                ),
//                Text(
//                  '\$100.00',
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontFamily: 'Nunito',
//                    color: azulTema,
//                  ),
//                ),
//              ],
//            ),
//            FlatButton(
//              child: Text(
//                'SIGUIENTE',
//                style: TextStyle(
//                    fontSize: 12,
//                    color: Colors.white,
//                    fontFamily: 'Nunito',
//                    fontWeight: FontWeight.bold),
//              ),
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => EscogerDirecciones(),
//                  ),
//                );
//              },
//              color: azulTema,
//              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(35)),
//            ),
//          ],
//        ),
//      ),
    );
  }

  Widget getDeliveryOptionsWidget(
      BuildContext context, StoreDelliveryInfo storeDeliveryInfo) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return DeliveryAlertDialogWidget();
            },
          );
        },
        child: ListTile(
          title: Row(
            children: <Widget>[
              Text(storeDeliveryInfo.storeName),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                storeDeliveryInfo.deliveryOptions[0].fee,
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
