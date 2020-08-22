import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/new_cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: grisClaroTema,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Mi Carrito',
            style: appBarStyle,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              //Custom Appbar

              //Total a pagar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'TOTAL',
                                  style: cartTotalStyle,
                                ),
                                Text(
                                  '\$${Provider.of<UserCartState>(context).totalPriceOfItems.toStringAsFixed(2)}',
                                  style: cartTotalPriceStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: azulTema,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              child: Text(
                                'PAGAR',
                                style: cartButtonPagarStyle,
                              ),
                              onPressed: () {
                                if (!Provider.of<LoginState>(context)
                                    .isAnon()) {
                                  if (Provider.of<UserCartState>(context)
                                          .cartProductList
                                          .length >
                                      0) {
                                    print('Stores currently on the cart');
                                    print(Provider.of<UserCartState>(context)
                                        .allStoreTagsList);
                                    print('Lista de Tiendas Filtradas');
                                    print(Provider.of<UserCartState>(context)
                                        .filterParentStoreTagList());
                                    Navigator.pushNamed(
                                        context, 'delivery_options');
                                  } else {
                                    print('======Carrito_Vacio======');
                                  }
                                } else {
                                  print(
                                      'User is Anon. Must sign in to access checkout');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<UserCartState>(
                  builder: (BuildContext context, UserCartState value,
                      Widget child) {
                    if (value.cartProductList.isEmpty) {
                      return ListView();
                    } else {
                      return child;
                    }
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount:
                        Provider.of<UserCartState>(context).cartItemsIds.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (index ==
                          Provider.of<UserCartState>(context)
                                  .cartItemsIds
                                  .length -
                              1) {
                        return Column(
                          children: <Widget>[
                            NewCartItemWidget(
                              itemId: Provider.of<UserCartState>(context)
                                  .cartProductList[index]
                                  .itemId,
                              itemName: Provider.of<UserCartState>(context)
                                  .cartProductList[index]
                                  .itemName,
                              imageUrl: Provider.of<UserCartState>(context)
                                  .cartProductList[index]
                                  .imageUrl,
                              finalPrice: Provider.of<UserCartState>(context)
                                  .cartProductList[index]
                                  .finalPrice,
                              colorHex: Provider.of<UserCartState>(context)
                                  .cartProductList[index]
                                  .hexColor,
                              parentStoreTag:
                                  Provider.of<UserCartState>(context)
                                      .cartProductList[index]
                                      .parentStoreTag,
                            ),
                            SizedBox(
                              //Todo Change to media query when store card uses media query
                              height: 100,
                            ),
                          ],
                        );
                      }

                      print(index);
                      return NewCartItemWidget(
                        itemId: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .itemId,
                        itemName: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .itemName,
                        imageUrl: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .imageUrl,
                        finalPrice: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .finalPrice,
                        colorHex: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .hexColor,
                        parentStoreTag: Provider.of<UserCartState>(context)
                            .cartProductList[index]
                            .parentStoreTag,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Cerrar la aplicacion??'),
          content: Text('Perderas los articulos en tu carrito...'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}
