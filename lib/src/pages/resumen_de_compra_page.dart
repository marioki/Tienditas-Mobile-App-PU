import 'package:app_tiendita/src/modelos/availability_model.dart';
import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/orden_exitosa_page.dart';
import 'package:app_tiendita/src/providers/send_order.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ResumenDeCompra extends StatefulWidget {
  @override
  _ResumenDeCompraState createState() => _ResumenDeCompraState();
}

class _ResumenDeCompraState extends State<ResumenDeCompra> {
  @override
  Widget build(BuildContext context) {
//For showing progress percentage
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    
    List<DeliveryOption> deliveryOptionList =
        Provider.of<UserCartState>(context).getListOfDeliveryInfo();
    Batch batch = Provider.of<UserCartState>(context).currentBatch;
    return Scaffold(
      backgroundColor: grisClaroTema,
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Resumen'
          '',
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Compras',
                      style: TextStyle(
                          color: azulTema,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  ListView.separated(
                    primary: false,
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    itemCount: batch.orders.length,
                    itemBuilder: (context, index) {
                      Order order = batch.orders[index];
                      //Precio de todos los productos
                      double orderTotalPrice = double.parse(order.amount) -
                          double.parse(order.deliveryOption.fee);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.storeTagName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito'),
                                ),
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: order.elements.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text('- '),
                                        Text(
                                          '${order.elements[index].quantity} x ',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily: 'Nunito'),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${order.elements[index].productName}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '\$${orderTotalPrice.toStringAsFixed(2)}',
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Envíos',
                      style: TextStyle(
                          color: azulTema,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: deliveryOptionList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deliveryOptionList[index].method,
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                              Text(
                                deliveryOptionList[index].name,
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('\$${deliveryOptionList[index].fee}'),
                          )
                        ],
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Impuestos',
                      style: TextStyle(
                          color: azulTema,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ITBMS 7%',
                        style: TextStyle(fontFamily: 'Nunito'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '\$${Provider.of<UserCartState>(context).impuesto.toStringAsFixed(2)}',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${Provider.of<UserCartState>(context).totalAmountOfBatch.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: azulTema,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                child: Text(
                  'PAGAR',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  pr.style(message: 'Validando Disponibilidad');
                  await pr.show();
                  UserTienditas userTienditas = Provider.of<LoginState>(context).getTienditaUser();
                  final userTokenId = Provider.of<LoginState>(context).currentUserIdToken;
                  final _batch = Provider.of<UserCartState>(context).currentBatch;
                  // Validar que existan suficientes unidades ordenadas
                  AvailabilityResponse availabilityResponse = await SendBatchOfOrders().checkInventoryAvailability(userTienditas, userTokenId, _batch);
                  await pr.hide();
                  if (200 == availabilityResponse.statusCode) {
                    pr.style(message: 'Finalizando Compra...');
                    await pr.show();
                    var response = await SendBatchOfOrders().sendBatchOfOrders(userTienditas, userTokenId, _batch);
                    final responseTienditasApi = responseFromJson(response.body);
                    //Comprueba que la respuesta fue exitosa
                    if (response.statusCode == 200) {
                      await pr.hide();
                      //Aqui comprobar que la compra fue exitosa
                      if (responseTienditasApi.statusCode == 200) {
                        //La compra fue exitosa
                        print(responseTienditasApi.body.message);
                        //Limpiar el Carrito
                        Provider.of<UserCartState>(context).deleteAllCartItems();
                        Provider.of<UserCartState>(context).calculateTotalPriceOfCart();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
                          return OrdenExitosaPage();
                        }), (route) => false);
                      } else {
                        // Orden Fallida
                        print('orden fallo con codigo ${responseTienditasApi.body.message}');
                        _showDialog(context, 'Intenta con otro metodo de pago.');
                      }
                    } else {
                      //Error de conexion
                      print('Error de conexión ${response.statusCode}');
                    }
                  } else if (400 == availabilityResponse.statusCode) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              elevation: 10,
                              title: Center(
                                child: Text(
                                  "Validando Inventario",
                                  style: TextStyle(
                                      color: Color(0xFF191660),
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Nunito"),
                                ),
                              ),
                              content: Container(
                                height: 200.0, // Change as per your requirement
                                width: 300.0, 
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) => Divider(),
                                  itemCount: availabilityResponse.body.notAvailable.length,
                                  itemBuilder: (context, index) {
                                    return _notAvailableItem(
                                      context,
                                      availabilityResponse.body.notAvailable[index],
                                    );
                                  }
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cerrar'),
                                  color: Color(0xFF191660),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ]
                            );
                          }
                        );
                      }
                    );
                  } else {
                    print("ORDEN FALLIDA");
                  }
                },
                color: azulTema,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notAvailableItem(BuildContext context, Available available) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "No hay suficientes unidades para el producto ${available.itemName}",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: "Nunito"),
          ),
          Text(
            "Unidades solicitadas: ${available.requested}",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: "Nunito"),
          ),
          Text(
            "Unidades disponible: ${available.available}",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: "Nunito"),
          ),
          SizedBox(height: 8),
      ],
    );
  }

  _showDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Listo"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
