import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/cart_counter.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: rosadoClaro,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mancuernas',
                    style: cartItemTitle,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    'My Loop Bands',
                    style: cartItemSubtitle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    '\$50',
                    style: cartItemPrice,
                  ),
                  CartCounter()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
