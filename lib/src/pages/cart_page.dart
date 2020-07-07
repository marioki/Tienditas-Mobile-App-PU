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
    return SafeArea(
      child: Column(
        children: <Widget>[
          //Custom Appbar
          Container(
            height: screenHeight * .25,
            //margin: EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: azulOscuro,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Center(
              child: Text(
                'Mi Carrito',
                style: storeTitleCardStyle,
              ),
            ),
          ),
          //Total a pagar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Card(
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
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('TOTAL'),
                          Text(
                            '\$198.00',
                            style: userCartTotalStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: azulOscuro,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'PAGAR',
                          style: storeTitleCardStyle,
                        ),
                        onPressed: () {},
                      )
                    ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
