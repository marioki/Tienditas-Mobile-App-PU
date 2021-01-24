import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool variantSelected = false;
    String variantName = "";
    String variantPrice = "";
    String variantQuantity = "";
    final ProductItemCard args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CartPage();
                  },
                ));
              },
              child: Align(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Badge(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                    badgeContent: Text(
                      Provider.of<UserCartState>(context)
                          .getCartItemsQuantity()
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    showBadge: (Provider.of<UserCartState>(context)
                                .getCartItemsQuantity() >
                            0)
                        ? true
                        : false,
                  ),
                ),
              ),
            ),
          ],
          actionsIconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: args.itemId,
                child: Swiper(
                  loop: false,
                  outer: false,
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      args.imagesUrlList[index],
                      fit: BoxFit.fitWidth,
                    );
                  },
                  itemCount: args.imagesUrlList.length,
                  pagination: SwiperPagination(),
                  control: SwiperControl(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              args.itemName,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Text((args.deliveryTime != null)
                                ? 'Tiempo de entrega ${args.deliveryTime}'
                                : '')
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Text(
                        '\$${args.finalPrice}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${args.description}',
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      wordSpacing: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            color: azulTema,
                            textColor: Colors.white,
                            child: Text('Al Carrito'),
                            onPressed: () {
                              if (args.variants != null && args.variants.length > 0) {
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
                                                items: args.variants.map((value) {
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
                                              "${args.itemName}",
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
                                                return("Variante Seleccionada\n$variantName a \$$variantPrice \nCantidad disponible: $variantQuantity");
                                              } else {
                                                return "";
                                              }
                                              }()),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
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
                                                    itemId: args.itemId,
                                                    itemName: "${args.itemName} - $variantName",
                                                    finalPrice: variantPrice,
                                                    imagesUrlList: args.imagesUrlList,
                                                    purchaseType: args.purchaseType,
                                                    registeredDate: args.registeredDate,
                                                    quantity: args.quantity,
                                                    hexColor: args.hexColor,
                                                    parentStoreTag: args.parentStoreTag,
                                                    description: args.description,
                                                    discountPrice: args.discountPrice,
                                                    discountPercentage:
                                                    args.discountPercentage
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
                                    itemId: args.itemId,
                                    itemName: args.itemName,
                                    finalPrice: args.finalPrice,
                                    imagesUrlList: args.imagesUrlList,
                                    purchaseType: args.purchaseType,
                                    registeredDate: args.registeredDate,
                                    quantity: args.quantity,
                                    hexColor: args.hexColor,
                                    parentStoreTag: args.parentStoreTag,
                                    description: args.description,
                                    discountPrice: args.discountPrice,
                                    discountPercentage:
                                    args.discountPercentage
                                  ),
                                );
                              }
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 300),
                                content: Text('Al carrito!'),
                              );
                              //Scaffold.of(context).showSnackBar(snackBar);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
