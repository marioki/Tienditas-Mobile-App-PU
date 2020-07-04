import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final Image image;
  final title, description;
  final int price, size, id;
  final Color color;

  ProductItemCard({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
  });

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
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mancuernas',
                  style: storeItemTitleStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Entrega Inmediata',
                  style: storeItemSubTitleStyle,
                ),
                Text(
                  '\$500',
                  style: storeItemPriceStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
