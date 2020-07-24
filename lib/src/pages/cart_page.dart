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

//Todo Crear provider global en el primer elemnto del arbol para guardar la lista de items
class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * .25),
        child: AppBar(
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
                                '\$${Provider.of<UserCartState>(context).totalPrice.toStringAsFixed(2)}',
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
                            onPressed: () {},
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
                      Provider.of<UserCartState>(context).cartItemsIds.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if(index == Provider.of<UserCartState>(context).cartItemsIds.length -1){
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
}
