import 'package:app_tiendita/src/maps/categories_map.dart';
import 'package:app_tiendita/src/modelos/producto.dart';
import 'package:app_tiendita/src/modelos/store_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:app_tiendita/src/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class StoreItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tienda args = ModalRoute.of(context).settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: getCategoryColor(args.category),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * .25,
                //margin: EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: getCategoryColor(args.category),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 25),
                    ),
                    IconButton(
                      enableFeedback: true,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            args.name,
                            style: storeTitleCardStyle,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '@${args.handle}',
                            style: storeDetailsCardStyle,
                          ),
                          Text(
                            'Seguidores: ${args.followers.toString()}',
                            style: storeDetailsCardStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 0),
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                fit: BoxFit.contain,
                                image: NetworkImage(args.image),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SearchBarWidget(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: kDefaultPaddin,
                      mainAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 3 / 5,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItemCard(
                        storeCategory: args.category,
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
}
