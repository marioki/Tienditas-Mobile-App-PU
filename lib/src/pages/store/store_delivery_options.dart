import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'edit_delivery_option.dart';

class StoreDeliveryOptions extends StatefulWidget {
  StoreDeliveryOptions({@required this.deliveryOptions, @required this.storeTagName});
  final List<DeliveryOption> deliveryOptions;
  final String storeTagName;
  @override
  _StoreDeliveryOptionsState createState() => _StoreDeliveryOptionsState();
}

class _StoreDeliveryOptionsState extends State<StoreDeliveryOptions> {
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
          'Métodos de Envío',
          style: appBarStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add
            ),
            iconSize: 45,
            color: Colors.lightGreenAccent,
            padding: EdgeInsets.only(right: 16.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDeliveryOptions(
                      appBarTitle: "Agregar Método de Envío",
                      storeTagName: widget.storeTagName
                    ),
                  )
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: widget.deliveryOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      DeliveryOptionCard(
                        name: widget.deliveryOptions[index].name,
                        fee: widget.deliveryOptions[index].fee,
                        method: widget.deliveryOptions[index].method,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditDeliveryOptions(
                                  appBarTitle: "Editar Método de Envío",
                                  storeTagName: widget.storeTagName,
                                  name: widget.deliveryOptions[index].name,
                                  fee: widget.deliveryOptions[index].fee,
                                  method: widget.deliveryOptions[index].method,
                                  id: widget.deliveryOptions[index].id,
                                ),
                              )
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryOptionCard extends StatelessWidget {
  DeliveryOptionCard({this.name, this.method, this.fee, this.onPressed});

  final String name;
  final String method;
  final String fee;
  final Function onPressed;

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
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "$name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"
                      ),
                    ),
                    FlatButton(
                      onPressed: onPressed,
                      child: Image(
                        width: 20,
                        height: 20,
                        image: AssetImage(
                            "assets/images/icons/edit_item_button.png"
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "Precio: $fee",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Nunito"
                  ),
                ),
                Text(
                  "$method",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Nunito"
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
