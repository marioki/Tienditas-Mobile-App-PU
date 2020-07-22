import 'package:app_tiendita/src/maps/categories_map.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:app_tiendita/src/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class StoreItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store args = ModalRoute.of(context).settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: getCategoryColor(args.hexColor),
      body: SafeArea(
        top: true,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                //margin: EdgeInsets.only(top: 24),
                height: screenHeight * .25,
                //margin: EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: getColorFromHex(args.hexColor),
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
                            args.storeName,
                            style: storeTitleCardStyle,
                          ),
                          SizedBox(height: 5),
                          Text(
                            args.storeTagName,
                            style: storeDetailsCardStyle,
                          ),
                          Text(
                            'Seguidores: 21,312',
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
                                fit: BoxFit.cover,
                                //ToDO cambiar a fit cuando mande imagen el backend
                                image:
                                    AssetImage('assets/images/Casa.png'),
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
              _generateStoreProductList(args, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateStoreProductList(Store args, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: FutureBuilder(
          future:
              ProductProvider().getStoreProducts(args.storeTagName, context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              Product product = snapshot.data;
              if (product.body.products.length < 1) {
                return Image(
                  image: AssetImage('assets/images/oops - Copy.jpg'),
                );
              }
              return GridView.builder(
                itemCount: product.body.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: kDefaultPaddin,
                  mainAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 3 / 5,
                ),
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    itemName: product.body.products[index].itemName,
                    itemId: product.body.products[index].itemId,
                    finalPrice: product.body.products[index].finalPrice,
                    itemSatus: product.body.products[index].itemSatus,
                    outstanding: product.body.products[index].outstanding,
                    purchaseType: product.body.products[index].purchaseType,
                    quantity: product.body.products[index].quantity,
                    registeredDate: product.body.products[index].registeredDate,
                    image: 'https://picsum.photos/200/300',
                    hexColor: args.hexColor,
                  );
                },
              );
            } else
              return Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          },
        ),
      ),
    );
  }
}
