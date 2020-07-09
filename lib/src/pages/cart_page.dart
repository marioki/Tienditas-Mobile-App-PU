import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Mi Carrito',
            style: appBarStyle,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Custom Appbar
//          Container(
//            height: screenHeight * .25,
//            //margin: EdgeInsets.only(bottom: 16),
//            clipBehavior: Clip.antiAlias,
//            decoration: BoxDecoration(
//              color: azulTema,
//              borderRadius: BorderRadius.only(
//                bottomLeft: Radius.circular(35),
//                bottomRight: Radius.circular(35),
//              ),
//            ),
//            child: Center(
//              child: Text(
//                'Mi Carrito',
//                style: storeTitleCardStyle,
//              ),
//            ),
//          ),
            //Total a pagar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TOTAL',
                                style: cartTotalStyle,
                              ),
                              Text(
                                '\$198.00',
                                style: cartTotalPriceStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: azulTema,
                            padding: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            child: Text(
                              'PAGAR',
                              style: cartButtonPagarStyle,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                  CartItemWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
