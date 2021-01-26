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
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    UserTienditas userInfo = Provider.of<LoginState>(context).getTienditaUser();
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _buildStoreStatus(resultTiendita),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          StoreCard(
                            amount: resultTiendita.body.store.pendingBalance,
                            description: "Saldo Retenido",
                            toolTipText:
                                'Este monto corresponde a tus ventas por completar.',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          StoreCard(
                            amount: resultTiendita.body.store.balance,
                            description: "Saldo Disponible",
                            toolTipText:
                                'Este monto corresponde a tus pedidos completados.\n Y puedes Retirarlos.',
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
                                    store: resultTiendita.body.store),
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
                                  ))
                              .then((value) => Provider.of<LoginState>(context)
                                  .reloadUserInfo());
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

  Widget _buildStoreStatus(StoreModel tienda) {
    if (tienda.body.store.storeStatus != "active") {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (() {
              if(tienda.body.store.deliveryOptions.length == 0) {
                return "Debe agregar métodos de envío para que podamos activar su tienda";
              } else if (tienda.body.store.phoneNumber.length == 0) {
                return "Debe agregar un  número telefónico para que podamos activar su tienda";
              } else if (tienda.body.store.description.length == 0) {
                return "Debe agregar una  descripción para que podamos activar su tienda";
              } else {
                return "Su tienda aún no está activa, tranquilo pronto lo estará.\nNos comunicaremos contigo si hay algún problema.";
              }
            }()),
            style: storeDetailsCardStyle,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}

class StoreCard extends StatelessWidget {
  StoreCard({this.amount, this.description, this.toolTipText});

  @required
  final String amount;
  @required
  final String description;
  @required
  final String toolTipText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Tooltip(
        message: toolTipText,
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
              vertical: 10,
            ),
            child: Column(children: <Widget>[
              Text(
                "\$$amount",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito"),
              ),
              Text(
                "$description",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Nunito"),
              ),
            ]),
          ),
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
