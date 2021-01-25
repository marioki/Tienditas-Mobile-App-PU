import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/user/edit_user_profile.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/my_profile_card_widget.dart';
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
    UserTienditas userInfo = Provider.of<LoginState>(context, listen:false).getTienditaUser();

    return Scaffold(
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
                              GestureDetector(
                                onLongPressUp: showEasterSnackBar,
                                child: Text(
                                  '\$${Provider.of<UserCartState>(context,listen: false).totalPriceOfItems.toStringAsFixed(2)}',
                                  style: cartTotalPriceStyle,
                                ),
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
                              if (Provider.of<LoginState>(context, listen:false)
                                      .getTienditaUser()
                                      .name ==
                                  null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUserProfile(
                                      user: userInfo,
                                    ),
                                  ),
                                );
                              } else {
                                if (!Provider.of<LoginState>(context, listen:false)
                                        .isAnon() &&
                                    (Provider.of<UserCartState>(context, listen:false)
                                            .cartProductList
                                            .length >
                                        0)) {
                                  print('Stores currently on the cart');
                                  print(Provider.of<UserCartState>(context, listen:false)
                                      .allStoreTagsList);
                                  print('Lista de Tiendas Filtradas');
                                  print(Provider.of<UserCartState>(context, listen:false)
                                      .filterParentStoreTagList());
                                  Provider.of<UserCartState>(context, listen:false)
                                      .clearSelectedDeliveryOptionList();
                                  Navigator.pushNamed(
                                      context, 'delivery_options');
                                } else {
                                  print(
                                      'User must not be anon/cart items must be > 0');
                                }
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
                builder:
                    (BuildContext context, UserCartState value, Widget child) {
                  if (value.cartProductList.isEmpty) {
                    return ListView();
                  } else {
                    return child;
                  }
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount:
                      Provider.of<UserCartState>(context,listen: false).cartItemsIds.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (index ==
                        Provider.of<UserCartState>(context,listen: false)
                                .cartItemsIds
                                .length -
                            1) {
                      return Column(
                        children: <Widget>[
                          NewCartItemWidget(
                            itemId: Provider.of<UserCartState>(context,listen: false)
                                .cartProductList[index]
                                .itemId,
                            itemName: Provider.of<UserCartState>(context,listen: false)
                                .cartProductList[index]
                                .itemName,
                            imagesUrlList: Provider.of<UserCartState>(context,listen: false)
                                .cartProductList[index]
                                .imagesUrlList,
                            finalPrice: Provider.of<UserCartState>(context,listen: false)
                                .cartProductList[index]
                                .finalPrice,
                            colorHex: Provider.of<UserCartState>(context,listen: false)
                                .cartProductList[index]
                                .hexColor,
                            parentStoreTag: Provider.of<UserCartState>(context,listen: false)
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
                      itemId: Provider.of<UserCartState>(context,listen: false)
                          .cartProductList[index]
                          .itemId,
                      itemName: Provider.of<UserCartState>(context,listen: false)
                          .cartProductList[index]
                          .itemName,
                      imagesUrlList: Provider.of<UserCartState>(context,listen: false)
                          .cartProductList[index]
                          .imagesUrlList,
                      finalPrice: Provider.of<UserCartState>(context,listen: false)
                          .cartProductList[index]
                          .finalPrice,
                      colorHex: Provider.of<UserCartState>(context,listen: false)
                          .cartProductList[index]
                          .hexColor,
                      parentStoreTag: Provider.of<UserCartState>(context,listen: false)
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

  showEasterSnackBar() {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 100),
      content: Text('...marioki'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
