import 'package:app_tiendita/src/modelos/user/user_order_batch.dart';
import 'package:app_tiendita/src/pages/user/user_order_elements.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class UserOrderDetail extends StatefulWidget {
  UserOrderDetail({this.batch});
  final Batch batch;
  @override
  _UserOrderDetailState createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> {
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
          'Order #${widget.batch.batchId.substring(1, 8)}',
          style: appBarStyle,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: widget.batch.orders.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      OrderDetailCard(
                        order: widget.batch.orders[index],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserOrderElements(
                                  order: widget.batch.orders[index],
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

class OrderDetailCard extends StatelessWidget {
  OrderDetailCard({this.onPressed, this.order});
  final Function onPressed;
  final Order order;
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
                    "Pedido a ${order.storeTagName}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito"
                    ),
                  ),
                  Text(
                    "Estado de la orden: ${order.orderStatus}",
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
          ),
        ),
      ),
    );
  }

}