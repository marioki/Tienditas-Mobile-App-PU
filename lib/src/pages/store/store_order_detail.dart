import 'dart:ui';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/store/order_model.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class StoreOrderDetail extends StatefulWidget {
  StoreOrderDetail({@required this.order});
  final Order order;
  @override
  _StoreOrderDetailState createState() => _StoreOrderDetailState();
}

class _StoreOrderDetailState extends State<StoreOrderDetail> {
  ItemStatusOptions selectedOption;
  bool isLoading = false;
  var response;
  List<ItemStatusOptions> itemStatusOptions = [
    ItemStatusOptions(option: "Recibido"),
    ItemStatusOptions(option: "Procesado"),
    ItemStatusOptions(option: "En Camino"),
    ItemStatusOptions(option: "Entregado"),
    ItemStatusOptions(option: "Cancelado"),
  ];
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
          title: Column(
            children: <Widget>[
              Text(
                  "Detalle del pedido"
              ),
              Text(
                "Fecha del pedido: ${widget.order.orderDate}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito"
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/icons/update_order_status_button.png'),
              padding: EdgeInsets.only(right: 16.0),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        elevation: 10,
                        title: Column(
                          children: <Widget>[
                            Image(
                              width: 60,
                              height: 60,
                              image: AssetImage(
                                  "assets/images/icons/truck_image.png"
                              ),
                            ),
                            Text(
                              "Marcar Como:",
                              style: TextStyle(
                                  color: Color(0xFF191660),
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Nunito"
                              ),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              DropdownButtonHideUnderline(
                                child: DropdownButton<ItemStatusOptions>(
                                  hint:  Text("Seleccionar Estado"),
                                  value: selectedOption,
                                  onChanged: (ItemStatusOptions value) {
                                    print(value.option);
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                  items: itemStatusOptions.map((ItemStatusOptions option) {
                                    return  DropdownMenuItem<ItemStatusOptions>(
                                      value: option,
                                      child: Text(
                                        option.option,
                                        style:  TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Guardar'),
                            color: Color(0xFF191660),
                            onPressed: () async {
                              if(selectedOption != null) {
                                response = await StoreProvider().updateOrderStatus(
                                    Provider.of<LoginState>(context).currentUserIdToken,
                                    widget.order.storeTagName,
                                    widget.order.orderId,
                                    selectedOption.option
                                );
                                if (response.statusCode == 200) {
                                  ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
                                  if (responseTienditasApi.statusCode == 200) {
                                    print(responseTienditasApi.body.message);
                                    isLoading = false;
                                    Navigator.of(context).pop();
                                    widget.order.orderStatus = selectedOption.option;
                                    /*setState(() {
                                      widget.order.orderStatus = selectedOption.option;
                                    });*/
                                  } else {
                                    print(responseTienditasApi.body.message);
                                    isLoading = false;
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      );
                    }
                    );
                  },
                );
              },
            )
          ],
        ),
      body: UserOrderInfo(
        order: widget.order,
      ),
    );
  }
}

class UserOrderInfo extends StatelessWidget {
  UserOrderInfo({this.order});

  final Order order;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(
                vertical: 8,
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
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
                      Text(
                        "Cliente: ${order.userName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"
                        ),
                      ),
                      Text(
                        "Teléfono: ${order.phoneNumber}",
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
                      Text(
                        "Dirección: ${order.userAddress.addressLine1}, ${order.userAddress.province}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Punto de referencia: ${order.userAddress.referencePoint}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]
                ),
              ),
            ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          width: double.infinity,
          child: Text(
            "Total: \$${order.amount}",
              style: TextStyle(
                  color: Color(0xFF191660),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"
              ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Estado de la orden: ${order.orderStatus}",
            style: TextStyle(
                color:Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: "Nunito"
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Productos",
            style: TextStyle(
                color: Color(0xFF191660),
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: "Nunito"
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 12),
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(
                vertical: 8,
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: order.orderElements.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OrderElementCard(
                              orderElement: order.orderElements[index],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderElementCard extends StatelessWidget {
  OrderElementCard({this.orderElement});
  final OrderElement orderElement;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 16
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${orderElement.itemName}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"
              ),
            ),
            Text(
              "Cantidad ordenada: ${orderElement.quantity}",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito"
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ]
      ),
    );
  }
}

class ItemStatusOptions {
  ItemStatusOptions({this.option});
  final String option;
}