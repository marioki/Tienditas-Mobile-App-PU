import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: grizItem,
//      elevation: 10,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://cdn.shopify.com/s/files/1/0101/2522/products/xrrrrrr.jpg?v=1586144742'),
            placeholder: AssetImage('assets/images/placeholder.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mancuernas',
                  style: storeItemTitleStyle,
                ),
                Text(
                  'Entrega Inmediata',
                  style: storeItemSubTitleStyle,
                ),
                Text(
                  '\$50',
                  style: storeItemPriceStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: RaisedButton(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: rosadoClaro,
              onPressed: () {},
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Al carrito',
                    style: storeDetailsCardStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
