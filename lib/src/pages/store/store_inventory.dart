import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  bool isExtended = true;
  ScrollController con;

  Future<Product> inventoryProducts;

  @override
  void initState() {
    super.initState();
    setState(() {
      inventoryProducts = fetchInventoryProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Image.asset(
            'assets/images/icons/add_product_item.png',
            fit: BoxFit.cover,
            height: 30,
            width: 30,
          ),
          elevation: 10,
          isExtended: isExtended,
          backgroundColor: azulTema,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateStoreProduct(storeTagName: widget.storeTagName),
                )).then((value) => reloadInventoryData());
          },
          label: Row(
            children: <Widget>[
              Text("Crear Producto"),
            ],
          )),
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
                  )).then((value) => reloadInventoryData());
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: inventoryProducts,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data;
            allProductsList = product.body.products;
            //print(allProductsList);
            if (isSearching) {
              finalListProductos = filteredProducts;
            } else {
              finalListProductos = allProductsList;
            }
            if (finalListProductos.length > 0) {
              return ListView.builder(
                controller: con,
                padding: EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: finalListProductos.length + 1,
                itemBuilder: (context, index) {
                  if (index <= finalListProductos.length - 1) {
                    return _productItem(
                        context,
                        finalListProductos[index],
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStoreInventory(
                                  storeTagName: widget.storeTagName,
                                  productElement: finalListProductos[index]),
                            ),
                          );
                        }
                    );
                  } else {
                    return SizedBox(
                      height: 75,
                    );
                  }
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _simplePopup(ProductElement productElement) => PopupMenuButton<int>(
    onSelected: (int value) {
      print(value);
      if (value == 1) {
        deleteProduct(productElement.itemId, context);
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Text("Eliminar"),
      ),
    ],
  );

  Widget _productItem(BuildContext context, ProductElement productElement, Function onPressed) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: onPressed,
        child: ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    Text(
                        "${productElement.itemName}",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      Text(
                        "Precio: \$${double.parse(productElement.finalPrice).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      Text(
                        "Cantidad disponible: ${productElement.quantity}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          trailing: _simplePopup(productElement),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }

  Future<void> deleteProduct(String itemId, BuildContext context) async {
    final userTokenId = Provider.of<LoginState>(context).currentUserIdToken;
    ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Eliminando producto',
      progressWidget: Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await pr.show();
    var response = await StoreProvider().deleteProduct(userTokenId, widget.storeTagName, itemId);
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        pr.hide();
        print(responseTienditasApi.body.message);
        setState(() {
          inventoryProducts = fetchInventoryProducts(context);
        });
      } else {
        print(responseTienditasApi.body.message);
        pr.hide();
      }
    }
  }

  Future<Product> fetchInventoryProducts(BuildContext context) {
    return ProductProvider().getStoreProducts(widget.storeTagName, context);
  }

  reloadInventoryData() {
    setState(() {
      inventoryProducts = fetchInventoryProducts(context);
    });
  }
}
