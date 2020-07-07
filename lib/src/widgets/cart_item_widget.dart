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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: rosadoClaro,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Mancuernas', style: storeTitleCardStyle,),
                Text('My Loop Bands', style: storeTitleCardStyle,),
              ],
            ),
            Column(
              children: <Widget>[
                Text('\$50',style: storeItemPriceStyle,),
                CartCounter()
              ],
            )
          ],
        ),
      ),
    );
  }
}
