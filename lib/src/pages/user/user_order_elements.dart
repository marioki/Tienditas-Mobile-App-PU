import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/user/user_order_batch.dart';
import 'package:app_tiendita/src/providers/user/confirmar_orden_recibida.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class UserOrderElements extends StatefulWidget {
  UserOrderElements({this.order});

  final Order order;

  @override
  _UserOrderElementsState createState() => _UserOrderElementsState();
}

class _UserOrderElementsState extends State<UserOrderElements> {
  ProgressDialog pr;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    isButtonEnabled = checkUserConfirmation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Productos Ordenados',
          style: appBarStyle,
        ),
      ),
      body: Column(
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
                        "Pedido a ${widget.order.storeTagName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      Text(
                        "Forma de envío: ${widget.order.deliveryOption.name}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dirección: ${widget.order.userAddress.addressLine1}, ${widget.order.userAddress.province}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Punto de referencia: ${widget.order.userAddress.referencePoint}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Estado de la orden: ${widget.order.orderStatus}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito"),
            ),
          ),
          RaisedButton(
            onPressed: isButtonEnabled ? () => sendUserConfirmation() : null,
            child: Text(
              'Confirmar Entrega',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            color: azulTema,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
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
                  fontFamily: "Nunito"),
            ),
          ),
          Flexible(
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
                  itemCount: widget.order.orderElements.length,
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
                                orderElement: widget.order.orderElements[index],
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
      ),
    );
  }

  sendUserConfirmation() async {
    pr = ProgressDialog(context, isDismissible: false);
    pr.style(
        message: 'Cargando...',
        progressWidget: Container(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
    pr.show();

    String userIdToken = Provider.of<LoginState>(context,listen: false).currentUserIdToken;
    var response = await OrderConfirmationByUser().confirmOrder(
      storeTagName: widget.order.storeTagName,
      orderId: widget.order.orderId,
      userIdToken: userIdToken,
    );
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi =
          responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200 &&
          responseTienditasApi.body.message ==
              'Orden actualizada correctamente') {
        print(
            '+++++++++++La entrega de la  orden ha sido confirmada por el usuario+++++++++++');
        setState(() {
          isButtonEnabled = false;
        });
        pr.hide();
      } else {
        //No se logro la confirmación intentar nueva mente
        print(
            '++++++++++++${responseTienditasApi.statusCode}  ${responseTienditasApi.body.message}+++++++++++++');
        pr.hide();
      }
    } else {
      //Error de Conexion
      print('+++++++++error: ${response.statusCode}+++++++++');
      pr.hide();
    }
  }

  bool checkUserConfirmation() {
    if (widget.order.orderStatus != 'Entregado') {
      return false;
    } else {
      return true;
    }
  }
}

class OrderElementCard extends StatelessWidget {
  OrderElementCard({this.orderElement});

  final OrderElement orderElement;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${orderElement.itemName}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
            Text(
              "Cantidad ordenada: ${orderElement.quantity}",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito"),
            ),
            SizedBox(
              height: 5,
            ),
          ]),
    );
  }
}
