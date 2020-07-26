import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCartItemWidget extends StatefulWidget {
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
  _NewCartItemWidgetState createState() => _NewCartItemWidgetState();
}

class _NewCartItemWidgetState extends State<NewCartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: getColorFromHex(widget.colorHex),
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
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.itemName,
                    style: storeTitleCardStyle,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: 0),
                  Text('', style: storeDetailsCardStyle),
                  Text('Entrega Inmediata', style: storeDetailsCardStyle),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  '\$${widget.finalPrice}',
                  style: cartItemPrice,
                ),
                SizedBox(
                  height: 10,
                ),
                createCartCounter(widget.itemId),
                FlatButton(
                  child: Icon(Icons.delete_forever),
                  onPressed: () {
                    Provider.of<UserCartState>(context).deleteProductFromCart(
                        ProductElement(itemId: widget.itemId));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  createCartCounter(String itemId) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent.withAlpha(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              onPressed: () {
                //--
                Provider.of<UserCartState>(context)
                    .subtractProductItemQuantity(itemId);
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                // if our item is less  then 10 then  it shows 01 02 like that
                Provider.of<UserCartState>(context)
                    .getItemAmountInCart(itemId)
                    .toString(),
                style: cartItemCounter,
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              onPressed: () {
                //++
                Provider.of<UserCartState>(context)
                    .addProductItemQuantity(itemId);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}