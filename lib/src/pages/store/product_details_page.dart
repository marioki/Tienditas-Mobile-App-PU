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

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;

  const ColoredSafeArea({Key key, @required this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Color(0xFF5f58a1),
      child: SafeArea(
        child: child,
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductItemCard args = ModalRoute.of(context).settings.arguments;

    return ColoredSafeArea(
      child: SafeArea(
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
                          child: FlatButton(
                            color: azulTema,
                            textColor: Colors.white,
                            child: Text('Al Carrito'),
                            onPressed: () {
                              Provider.of<UserCartState>(context)
                                  .addProductoToCart(
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
                                        args.discountPercentage),
                              );
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
                    //Todo descripcion del producto
                    // Expanded(
                    //   child: Text(
                    //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
                    //     ', sed do eiusmod tempor incididunt ut labore et dolo'
                    //     're magna aliqua. Ut enim ad minim veniam, quis nostr'
                    //     'ud exercitation ullamco laboris nisi ut aliquip ex '
                    //     'ea commodo consequat. Duis aute irure dolor in repre'
                    //     'henderit in voluptate velit esse cillum dolore eu f'
                    //     'ugiat nulla pariatur. Excepteur sint occaecat cupida'
                    //     'tat non proident, sunt in culpa qui officia deserunt'
                    //     ' mollit anim id est laborum',
                    //     maxLines: 4,
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: Colors.black,
                    //       wordSpacing: 3,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              color: Color(0xFF5f58a1),
                              textColor: Colors.white,
                              child: Text('Al Carrito'),
                              onPressed: () {
                                Provider.of<UserCartState>(context)
                                    .addProductoToCart(
                                  ProductElement(
                                    itemId: args.itemId,
                                    itemName: args.itemName,
                                    finalPrice: args.finalPrice,
                                    imageUrl: args.imageUrl,
                                    purchaseType: args.purchaseType,
                                    registeredDate: args.registeredDate,
                                    quantity: args.quantity,
                                    hexColor: args.hexColor,
                                    parentStoreTag: args.parentStoreTag,
                                  ),
                                );
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
      ),
    );
  }
}
