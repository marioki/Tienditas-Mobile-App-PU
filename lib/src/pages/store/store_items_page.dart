import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreItemsPage extends StatefulWidget {
  @override
  _StoreItemsPageState createState() => _StoreItemsPageState();
}

class _StoreItemsPageState extends State<StoreItemsPage> {
  bool isSearching = false;
  List<ProductElement> allProductsList = [];
  List<ProductElement> filteredProducts = [];

  List<ProductElement> finalListProductos;

  @override
  Widget build(BuildContext context) {
    final Store args = ModalRoute.of(context).settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xFF5f58a1),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                //Custom appBar
                Container(
                  //margin: EdgeInsets.only(top: 24),
                  height: 100,
                  //margin: EdgeInsets.only(bottom: 16),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Color(0xFF5f58a1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 8),
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
                                  child: FadeInImage(
                                    image: NetworkImage(args.iconUrl),
                                    placeholder: AssetImage(
                                        'assets/images/tienditas_placeholder.png'),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Text(
                                args.originalStoreName,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: storeTitleCardStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              args.storeTagName,
                              style: storeDetailsCardStyle,
                            ),
                            Flexible(
                              child: Container(
                                width: 200,
                                child: Text(
                                  args.description,
                                  maxLines: 2,
                                  style: storeDetailsCardStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CartPage();
                            },
                          ));
                        },
                        child: Badge(
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
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
                    ],
                  ),
                ),
                _searchBarWidget(),
                _generateStoreProductList(args, context),
              ],
            ),
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
              allProductsList = product.body.products;
              if (isSearching) {
                finalListProductos = filteredProducts;
              } else {
                finalListProductos = allProductsList;
              }

              if (finalListProductos.length < 1) {
                return Image(
                  image: AssetImage('assets/images/oops - Copy.jpg'),
                );
              }
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: finalListProductos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: kDefaultPaddin,
                  mainAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 3 / 5,
                ),
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    itemName: finalListProductos[index].itemName,
                    itemId: finalListProductos[index].itemId,
                    finalPrice: finalListProductos[index].finalPrice,
                    itemSatus: finalListProductos[index].itemStatus,
                    outstanding: finalListProductos[index].outstanding,
                    purchaseType: finalListProductos[index].purchaseType,
                    quantity: finalListProductos[index].quantity,
                    registeredDate: finalListProductos[index].registeredDate,
                    image: finalListProductos[index].imageUrl,
                    hexColor: args.hexColor,
                    imageUrl: finalListProductos[index].imageUrl,
                    parentStoreTag: args.storeTagName,
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

  void _filterProducts(value) {
    setState(() {
      filteredProducts = allProductsList
          .where((product) => product.itemName.toLowerCase().contains(value))
          .toList();
      print('Lista filtrada $filteredProducts');
    });
  }

  _searchBarWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 42),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Buscar',
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
        onChanged: (value) {
          isSearching = true;
          _filterProducts(value.toLowerCase());
        },
      ),
    );
  }
}
