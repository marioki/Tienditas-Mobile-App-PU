import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:flutter/cupertino.dart';

import 'create_store_product.dart';
import 'edit_store_product.dart';

class StoreInventory extends StatefulWidget {
  StoreInventory({this.storeTagName});

  final String storeTagName;

  @override
  _StoreInventoryState createState() => _StoreInventoryState();
}

class _StoreInventoryState extends State<StoreInventory> {
  bool isSearching = false;
  List<ProductElement> allProductsList = [];
  List<ProductElement> filteredProducts = [];
  List<ProductElement> finalListProductos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Mis Productos',
          style: appBarStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/icons/add_product_item.png'),
            padding: EdgeInsets.only(right: 16.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateStoreProduct(storeTagName: widget.storeTagName),
                  ));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            ProductProvider().getStoreProducts(widget.storeTagName, context),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data;
            allProductsList = product.body.products;
            print(allProductsList);
            if (isSearching) {
              finalListProductos = filteredProducts;
            } else {
              finalListProductos = allProductsList;
            }
            if (finalListProductos.length > 0) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: finalListProductos.length,
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    itemName: finalListProductos[index].itemName,
                    price: finalListProductos[index].finalPrice,
                    imageUrl: finalListProductos[index].imageUrl,
                    quantity: finalListProductos[index].quantity,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStoreInventory(
                                storeTagName: widget.storeTagName,
                                productElement: finalListProductos[index]),
                          ));
                    },
                  );
                },
              );
            } else {
              return Container(
                height: 400,
                child: Center(
                  child: Text("Agregue productos"),
                ),
              );
            }
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductItemCard extends StatelessWidget {
  ProductItemCard(
      {this.itemName,
      this.price,
      this.imageUrl,
      this.onPressed,
      this.quantity});

  final String itemName;
  final String price;
  final String imageUrl;
  final String quantity;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(
            vertical: 8,
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      image: NetworkImage("$imageUrl"),
                    ),
                  ),
                  Text(
                    "$itemName",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito"),
                  ),
                  Text(
                    "Precio: $price",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Nunito"),
                  ),
                  Text(
                    "Cantidad disponible: $quantity",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Nunito"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
