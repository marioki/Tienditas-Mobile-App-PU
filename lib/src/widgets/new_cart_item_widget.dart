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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      placeholder:
                          AssetImage('assets/images/tienditas_placeholder.png'),
                      image: NetworkImage(widget.imageUrl),
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.itemName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: azulTema,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '@StoreTag',
                          style: TextStyle(
                            color: azulTema,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Tipo de Entrega.',
                          style: TextStyle(
                            color: azulTema,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Nunito',
                          ),
                        )
                      ],
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
              ),
            ],
          )
        ],
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
