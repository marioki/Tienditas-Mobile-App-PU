import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:flutter/material.dart';

import 'cart_counter.dart';

class NewCartItemWidget extends StatelessWidget {
  final String quantity;
  final String itemName;
  final String purchaseType;
  final String colorHex;

  //Outstanding outstanding; //Todo definir tipo de variable
  final String registeredDate;
  final String itemId;
  final String finalPrice;

  //ItemSatus itemSatus; //Todo definir tipo de variable
  final String imageUrl;

  const NewCartItemWidget(
      {Key key,
      this.quantity,
      this.itemName,
      this.purchaseType,
      this.registeredDate,
      this.itemId,
      this.finalPrice,
      this.imageUrl,
      this.colorHex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: getColorFromHex(colorHex),
      //getColorFromHex(colorHex)
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: size.height * .051,
                child: ClipOval(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://picsum.photos/200/300'),
                        placeholder:
                            AssetImage('assets/images/placeholder.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(itemName, style: storeTitleCardStyle),
                  SizedBox(height: 0),
                  Text('', style: storeDetailsCardStyle),
                  Text('Entrega Inmediata', style: storeDetailsCardStyle),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  '\$$finalPrice',
                  style: cartItemPrice,
                ),
                SizedBox(
                  height: 10,
                ),
                CartCounter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
