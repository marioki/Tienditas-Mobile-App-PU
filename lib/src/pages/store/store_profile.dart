import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/store/edit_store.dart';
import 'package:app_tiendita/src/pages/store/store_delivery_options.dart';
import 'package:app_tiendita/src/pages/store/store_inventory.dart';
import 'package:app_tiendita/src/pages/store/store_orders.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreProfile extends StatefulWidget {
  @override
  _StoreProfileState createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    User userInfo = Provider.of<LoginState>(context).getTienditaUser();
    StoreModel resultTiendita;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Mi Tienda',
          style: appBarStyle,
        ),
      ),
      body: FutureBuilder(
          future: StoreProvider().getStoreInfo(context, userInfo.stores[0]),
          builder: (BuildContext context, snapshot) {
            print(snapshot.hasData);
            print(snapshot.data);
            if (snapshot.hasData) {
              resultTiendita = snapshot.data;
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      StoreCardWidget(
                        name: resultTiendita.body.store.storeName,
                        handle: resultTiendita.body.store.storeTagName,
                        colorHex: resultTiendita.body.store.hexColor,
                        image: resultTiendita.body.store.iconUrl,
                        category: resultTiendita.body.store.categoryName,
                        followers: null,
                        provinceName: resultTiendita.body.store.provinceName,
                        description: resultTiendita.body.store.description,
                        originalStoreName:
                            resultTiendita.body.store.originalStoreName,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          StoreCard(
                            amount: resultTiendita.body.store.pendingBalance,
                            description: "Saldo Retenido",
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          StoreCard(
                            amount: resultTiendita.body.store.balance,
                            description: "Saldo Disponible",
                          ),
                        ],
                      ),
                      ActionButton(
                        iconName: "camion",
                        description: "Pedidos",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreOrders(
                                        storeTagName: resultTiendita
                                            .body.store.storeTagName,
                                      )));
                        },
                      ),
                      ActionButton(
                        iconName: "my_products",
                        description: "Mis Productos",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreInventory(
                                  storeTagName:
                                      resultTiendita.body.store.storeTagName,
                                ),
                              ));
                        },
                      ),
                      ActionButton(
                        iconName: "camion",
                        description: "Métodos de Envíos",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreDeliveryOptions(
                                  store: resultTiendita.body.store
                                ),
                              ));
                        },
                      ),
                      ActionButton(
                        iconName: "store_bw",
                        description: "Editar Tienda",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditStore(
                                  store: resultTiendita.body.store,
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

class StoreCard extends StatelessWidget {
  StoreCard({this.amount, this.description});

  final String amount;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(children: <Widget>[
            Text(
              "\$ $amount",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
            Text(
              "$description",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito"),
            ),
          ]),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  ActionButton({this.iconName, this.description, this.onPressed});
  final String iconName;
  final String description;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Image(
              width: 40,
              height: 40,
              image: AssetImage("assets/images/icons/$iconName.png"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "$description",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito"),
            )
          ],
        ),
      ),
    );
  }
}
