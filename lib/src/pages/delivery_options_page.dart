import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/checkout_sequence/escoger_direcciones_page.dart';
import 'package:app_tiendita/src/providers/delivery_cost_provider.dart';
import 'package:app_tiendita/src/providers/store_delivery_options_provider.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/alert_dialogs/delivery_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryOptionsPage extends StatefulWidget {
  @override
  _DeliveryOptionsPageState createState() => _DeliveryOptionsPageState();
}

class _DeliveryOptionsPageState extends State<DeliveryOptionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool nextButtonIsEnabled = false;
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
            'Delivery ',
            style: appBarStyle,
          ),
        ),
      ),
      body: FutureBuilder(
        //Todo el metodo de getStoreDeliveryOptions retorne una lista de listas
        future: DeliveryOptionsProvider().getStoreDeliveryOptions(context,
            Provider.of<UserCartState>(context).filterParentStoreTagList()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<StoreDeliveryInfo> listOfOptions = snapshot.data;
            return Column(
              children: [
                ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: listOfOptions.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < listOfOptions.length) {
                        StoreDeliveryInfo deliveryInfo = listOfOptions[index];

                        return ListTile(
                          title: Text(deliveryInfo.storeName),
                          trailing: Text(deliveryInfo.deliveryOptions[0].fee),
                          subtitle:
                              Text(deliveryInfo.deliveryOptions[0].method),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                        );
                      }
                    }),
              ],
            );
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
                FutureBuilder(
                  future: TotalDeliveryFee().getTotalFee(
                      context,
                      Provider.of<UserCartState>(context)
                          .filterParentStoreTagList()),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      Provider.of<UserCartState>(context)
                          .setDeliveryTotalCost(snapshot.data);
                      return Text(
                        '\$${snapshot.data.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: azulTema,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
            RaisedButton(
              child: Text(
                'SIGUIENTE',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Provider.of<UserCartState>(context)
                    .calculateTotalAmountOfBatch();
                Provider.of<UserCartState>(context).generateOrderList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EscogerDirecciones(),
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
    );
  }

  Widget getDeliveryOptionsWidget(
      BuildContext context, StoreDeliveryInfo storeDeliveryInfo) {
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
