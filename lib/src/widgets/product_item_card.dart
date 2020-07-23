import 'package:app_tiendita/src/maps/categories_map.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemCard extends StatelessWidget {
  final String image;
  final String quantity;
  final String itemName;
  final PurchaseType purchaseType;
  final Outstanding outstanding;
  final String registeredDate;
  final String itemId;
  final String finalPrice;
  final ItemSatus itemSatus;
  final String imageUrl;
  final String hexColor;

  const ProductItemCard(
      {Key key,
      @required this.quantity,
      @required this.itemName,
      @required this.purchaseType,
      @required this.outstanding,
      @required this.registeredDate,
      @required this.itemId,
      @required this.finalPrice,
      @required this.itemSatus,
      this.imageUrl,
      @required this.hexColor,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Todo: Fix la cantidad de texto cambian el tamaño de la imagen del producto
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
                image: NetworkImage(image),
                placeholder: AssetImage('assets/images/oops - Copy.jpg'),
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
                  itemName,
                  style: storeItemTitleStyle,
                ),
                Text(
                  'dilibiry',
                  style: storeItemSubTitleStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$$finalPrice',
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
              color: getColorFromHex(hexColor),
              onPressed: () {
                Provider.of<UserCartState>(context)
                    .addProductoToCart(ProductElement(
                  itemId: itemId,
                  itemName: itemName,
                  finalPrice: finalPrice,
                  imageUrl: imageUrl,
                  purchaseType: purchaseType,
                  registeredDate: registeredDate,
                  quantity: quantity,
                  hexColor: hexColor,
                ));
              },
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
