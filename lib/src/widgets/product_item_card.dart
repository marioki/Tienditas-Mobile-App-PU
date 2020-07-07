import 'package:app_tiendita/src/maps/categories_map.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final String image = 'https://picsum.photos/200/300';
  final String name = 'Producto 1';
  final String delivery = 'Entrega Inmediata';
  final double price = 199;
  final String storeCategory;

  ProductItemCard({
//    this.image,
//    this.name,
//    this.price,
    this.storeCategory,
//    this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
//      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: grizItem,
//      elevation: 10,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              //margin: EdgeInsets.only(top: 10),
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://picsum.photos/200/300'),
                placeholder: AssetImage('assets/images/placeholder.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: storeItemTitleStyle,
                ),
                Text(
                  delivery,
                  style: storeItemSubTitleStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$$price',
                  style: storeItemPriceStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
            child: RaisedButton(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: getCategoryColor(storeCategory),
              onPressed: () {},
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Al carrito',
                    style: storeItemCartButtonTextStyle,
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
