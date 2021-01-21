import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/pages/store/product_details_page.dart';
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
  final String itemSatus;
  final List<String> imagesUrlList;
  final String hexColor;
  final String parentStoreTag;
  final String deliveryTime;
  final String description;
  final String discountPrice;
  final String discountPercentage;
  final List<Variant> variants;

  //todo Esto puede ser reemplazado por un atributo de tipo productElement
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
      @required this.imagesUrlList,
      @required this.hexColor,
      @required this.parentStoreTag,
      this.image,
      @required this.deliveryTime,
      this.description,
      this.discountPrice,
      this.discountPercentage,
      this.variants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double _finalPrice = double.parse(source);
    //Todo: Fix la cantidad de texto cambian el tamaño de la imagen del producto
    bool variantSelected = false;
    String variantName = "";
    String variantPrice = "";
    String variantQuantity = "";
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
            child: GestureDetector(
              onTap: () => goToProductDetails(context),
              child: Container(
                width: double.infinity,
                child: Hero(
                  tag: itemId,
                  child: Image(
                    image: NetworkImage(imagesUrlList[0]),
                    fit: BoxFit.cover,
                  ),
                ),
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
                  maxLines: 1,
                  style: storeItemTitleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                //Todo  Tipo de Compra
                // Text(
                //   purchaseType.toString(),
                //   style: storeItemSubTitleStyle,
                // ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$${(double.parse(finalPrice).toStringAsFixed(2))}',
                  style: storeItemPriceStyle,
                ),
                Text((deliveryTime != null)
                    ? 'entrega' + ' ' + deliveryTime
                    : ''),
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
                if (variants != null && variants.length > 0) {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            elevation: 10,
                            title: Text(
                              "Selecciona una variante",
                              style: TextStyle(
                                  color: Color(0xFF191660),
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Nunito"),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text("Seleccionar variante"),
                                    //value: _value,
                                    onChanged: (newValue) {
                                      setState(() {
                                        variantName = newValue.name;
                                        variantPrice = newValue.price;
                                        variantQuantity = newValue.quantity;
                                        variantSelected = true;
                                      });
                                    },
                                    items: variants.map((value) {
                                      return new DropdownMenuItem(
                                        child: new Text(
                                          "${value.name} a \$${value.price}"
                                        ),
                                        value: value,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${itemName}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Nunito"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  (() {
                                  if (variantSelected) {
                                    return("$variantName a \$$variantPrice \nCantidad disponible: $variantQuantity");
                                  } else {
                                    return "";
                                  }
                                  }()),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Nunito"),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Agregar al carrito'),
                                color: Color(0xFF191660),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  if (variantSelected) {
                                    Provider.of<UserCartState>(context).addProductoToCart(
                                      ProductElement(
                                        itemId: itemId,
                                        itemName: "$itemName - $variantName",
                                        finalPrice: variantPrice,
                                        imagesUrlList: imagesUrlList,
                                        purchaseType: purchaseType,
                                        registeredDate: registeredDate,
                                        quantity: quantity,
                                        hexColor: hexColor,
                                        parentStoreTag: parentStoreTag,
                                        description: description,
                                        discountPrice: discountPrice,
                                        discountPercentage: discountPercentage
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    print("Awe, escoge una variante");
                                  }
                                },
                              ),
                            ],
                          );
                        });
                      },
                    );
                } else {
                  Provider.of<UserCartState>(context).addProductoToCart(
                    ProductElement(
                        itemId: itemId,
                        itemName: itemName,
                        finalPrice: finalPrice,
                        imagesUrlList: imagesUrlList,
                        purchaseType: purchaseType,
                        registeredDate: registeredDate,
                        quantity: quantity,
                        hexColor: hexColor,
                        parentStoreTag: parentStoreTag,
                        discountPrice: discountPrice,
                        discountPercentage: discountPercentage,
                        description: description
                    ),
                  );
                  final snackBar = SnackBar(
                    duration: Duration(milliseconds: 300),
                    content: Text('Al carrito!'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }
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
  goToProductDetails(BuildContext context) {
    return Navigator.pushNamed(context, 'product_details_page',
        arguments: ProductItemCard(
          quantity: this.quantity,
          itemName: this.itemName,
          purchaseType: this.purchaseType,
          outstanding: this.outstanding,
          registeredDate: this.registeredDate,
          itemId: this.itemId,
          finalPrice: this.finalPrice,
          itemSatus: this.itemSatus,
          imagesUrlList: this.imagesUrlList,
          hexColor: this.hexColor,
          parentStoreTag: this.parentStoreTag,
          deliveryTime: this.deliveryTime,
          image: null,
          description: this.description,
          discountPrice: this.discountPrice,
          discountPercentage: this.discountPercentage,
          variants: this.variants,
        ));
  }
}
