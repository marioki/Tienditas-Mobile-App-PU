import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumenDeCompra extends StatefulWidget {
  @override
  _ResumenDeCompraState createState() => _ResumenDeCompraState();
}

class _ResumenDeCompraState extends State<ResumenDeCompra> {
  @override
  Widget build(BuildContext context) {
    List<StoreDeliveryInfo> deliveryInfoList =
        Provider.of<UserCartState>(context).getListOfDeliveryInfo();
    Batch batch = Provider.of<UserCartState>(context).currentBatch;
    return Scaffold(
      backgroundColor: grisClaroTema,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Resumen',
            style: appBarStyle,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: order.elements.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '- ${order.elements[index].productName}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[600]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '\$${order.amount.toString()}',
                        ),
                      )
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Envios',
                  style: TextStyle(
                      color: azulTema,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito'),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: deliveryInfoList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(deliveryInfoList[index]
                              .deliveryOptions[0]
                              .method),
                          Text(deliveryInfoList[index].deliveryOptions[0].name),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                            '\$${deliveryInfoList[index].deliveryOptions[0].fee}'),
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
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
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
                    '\$50',
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
                onPressed: () {},
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

  Widget resumenItemWidget(String storeName) {}
}
