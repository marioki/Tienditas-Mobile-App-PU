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

  final String parentStoreTag;

  const NewCartItemWidget({Key key,
    this.quantity,
    this.itemName,
    this.purchaseType,
    this.registeredDate,
    this.itemId,
    this.finalPrice,
    this.imageUrl,
    this.colorHex, this.parentStoreTag,})
      : super(key: key);

  @override
  _NewCartItemWidgetState createState() => _NewCartItemWidgetState();
}

class _NewCartItemWidgetState extends State<NewCartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
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
                        image: NetworkImage(widget.imageUrl),
                        placeholder: AssetImage(
                            'assets/images/tienditas_placeholder.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Icon(Icons.delete_outline),
            onTap: () {
              Provider.of<UserCartState>(context)
                  .deleteProductFromCart(ProductElement(itemId: widget.itemId));
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$${widget.finalPrice}',
                style: TextStyle(
                  color: azulTema,
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Provider.of<UserCartState>(context)
                            .subtractProductItemQuantity(widget.itemId);
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      Provider.of<UserCartState>(context)
                          .getItemAmountInCart(widget.itemId)
                          .toString(),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Provider.of<UserCartState>(context)
                            .addProductItemQuantity(widget.itemId);
                      },
                    ),
                  ],
                ),
                createCartCounter(widget.itemId),
                FlatButton(
                  child: Icon(Icons.delete_forever),
                  onPressed: () {
                    Provider.of<UserCartState>(context).deleteProductFromCart(
                      ProductElement(
                        itemId: widget.itemId,
                        itemName: widget.itemName,
                        finalPrice: widget.finalPrice,
                        imageUrl: widget.imageUrl,
                        registeredDate: widget.registeredDate,
                        quantity: widget.quantity,
                        hexColor: widget.colorHex,
                        parentStoreTag: widget.parentStoreTag,
                      ),
                    );
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
