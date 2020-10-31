import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductItemCard args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: args.itemId,
                  child: Image(
                    image: NetworkImage(args.imageUrl),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              args.itemName,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Nunito',
                              ),
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
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
                        ', sed do eiusmod tempor incididunt ut labore et dolo'
                        're magna aliqua. Ut enim ad minim veniam, quis nostr'
                        'ud exercitation ullamco laboris nisi ut aliquip ex '
                        'ea commodo consequat. Duis aute irure dolor in repre'
                        'henderit in voluptate velit esse cillum dolore eu f'
                        'ugiat nulla pariatur. Excepteur sint occaecat cupida'
                        'tat non proident, sunt in culpa qui officia deserunt'
                        ' mollit anim id est laborum',
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          wordSpacing: 3,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                color: azulTema,
                                textColor: Colors.white,
                                child: Text('Al Carrito'),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
