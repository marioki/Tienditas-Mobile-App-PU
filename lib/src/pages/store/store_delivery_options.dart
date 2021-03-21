import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'edit_delivery_option.dart';

class StoreDeliveryOptions extends StatefulWidget {
  StoreDeliveryOptions({@required this.store});
  final Store store;
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
            iconSize: 40,
            padding: EdgeInsets.only(right: 16.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDeliveryOptions(
                        appBarTitle: "Agregar Método de Envío",
                        storeTagName: widget.store.storeTagName
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
              itemCount: widget.store.deliveryOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      DeliveryOptionCard(
                        deliveryOption: widget.store.deliveryOptions[index],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditDeliveryOptions(
                                  appBarTitle: "Editar Método de Envío",
                                  storeTagName: widget.store.storeTagName,
                                  name: widget.store.deliveryOptions[index].name,
                                  fee: widget.store.deliveryOptions[index].fee,
                                  method: widget.store.deliveryOptions[index].method,
                                  id: widget.store.deliveryOptions[index].id
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
  DeliveryOptionCard({this.deliveryOption, this.onPressed});

  final DeliveryOption deliveryOption;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
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
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 16
            ),
            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${deliveryOption.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"
                          ),
                        ),
                        Text(
                          "Precio: ${deliveryOption.fee}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Nunito"
                          ),
                        ),
                        Text(
                          "${deliveryOption.method}",
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
      ),
    );
  }
}
