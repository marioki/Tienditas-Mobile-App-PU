import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/store/order_model.dart';
import 'package:app_tiendita/src/pages/store/store_order_detail.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class StoreOrders extends StatefulWidget {
  StoreOrders({this.storeTagName});

  final String storeTagName;

  @override
  _StoreOrdersState createState() => _StoreOrdersState();
}

class _StoreOrdersState extends State<StoreOrders> {
  @override
  Widget build(BuildContext context) {
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
          'Pedidos',
          style: appBarStyle,
        ),
      ),
      body: FutureBuilder(
        future: StoreProvider().getStoreOrders(context, widget.storeTagName),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            StoreOrdersResult storeOrder = snapshot.data;
            if (storeOrder.body.orders.length > 0) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: storeOrder.body.orders.length,
                itemBuilder: (context, index) {
                  return OrderItemCard(
                    amount: storeOrder.body.orders[index].amount,
                    userName: storeOrder.body.orders[index].userName,
                    orderDate: storeOrder.body.orders[index].orderDate,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreOrderDetail(
                              order: storeOrder.body.orders[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Container(
                height: 400,
                child: Center(child: Text("No hay ordenes registradas")),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  OrderItemCard({this.amount, this.userName, this.orderDate, this.onPressed});

  final String amount;
  final String userName;
  final String orderDate;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Pedido para $userName",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito"),
                ),
                Text(
                  "Hora del pedido: $orderDate",
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
                  "Total: $amount",
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
    );
  }
}
