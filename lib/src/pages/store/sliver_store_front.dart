import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math' as math;

class SliverStoreFront extends StatefulWidget {
  @override
  _SliverStoreFrontState createState() => _SliverStoreFrontState();
}

class _SliverStoreFrontState extends State<SliverStoreFront> {
  Future<CategoryResponseModel> categoryResponse;
  Future<Tiendita> tienditaResponse;

  //Pull to refres package
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    setState(() {
      tienditaResponse = fetchTienditas(context);
      categoryResponse = fetchCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: azulTema,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: CustomScrollView(
              slivers: [
                getNewCustomAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return FutureBuilder(
                        future: tienditaResponse,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          Tiendita miTienda = snapshot.data;
                          if (snapshot.hasData) {
                            if (index < miTienda.body.stores.length) {
                              return StoreCardWidget(
                                name: miTienda.body.stores[index].storeName,
                                handle:
                                    miTienda.body.stores[index].storeTagName,
                                category:
                                    miTienda.body.stores[index].categoryName,
                                colorHex: miTienda.body.stores[index].hexColor,
                                image: miTienda.body.stores[index].iconUrl,
                                description:
                                    miTienda.body.stores[index].description,
                                followers: null,
                                originalStoreName: miTienda
                                    .body.stores[index].originalStoreName,
                                provinceName:
                                    miTienda.body.stores[index].provinceName,
                              );
                            } else
                              return Container();
                          } else {
                            return Container();
                          }
                        },
                      );
                      //return Container(color: getRandomColor(), height: 150.0);
                    },
                    // Or, uncomment the following line:
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget getTiendasListViewBuilder() {
    return SmartRefresher(
      physics: BouncingScrollPhysics(),
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Text('¡Actualizado!'),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            //body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Error de conexión...");
          } else if (mode == LoadStatus.canLoading) {
            // body = Text("release to load more");
          } else {
            //body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: FutureBuilder(
        future: tienditaResponse,
        builder: (
          BuildContext context,
          snapshot,
        ) {
          if (snapshot.hasData) {
            Tiendita miTienda = snapshot.data;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: miTienda.body.stores.length,
              padding: EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == miTienda.body.stores.length - 1) {
                  return Column(
                    children: <Widget>[
                      StoreCardWidget(
                        name: miTienda.body.stores[index].storeName,
                        handle: miTienda.body.stores[index].storeTagName,
                        category: miTienda.body.stores[index].categoryName,
                        colorHex: miTienda.body.stores[index].hexColor,
                        image: miTienda.body.stores[index].iconUrl,
                        description: miTienda.body.stores[index].description,
                        followers: null,
                        originalStoreName:
                            miTienda.body.stores[index].originalStoreName,
                        provinceName: miTienda.body.stores[index].provinceName,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  );
                }
                return StoreCardWidget(
                  name: miTienda.body.stores[index].storeName,
                  handle: miTienda.body.stores[index].storeTagName,
                  category: miTienda.body.stores[index].categoryName,
                  colorHex: miTienda.body.stores[index].hexColor,
                  image: miTienda.body.stores[index].iconUrl,
                  description: miTienda.body.stores[index].description,
                  followers: null,
                  originalStoreName:
                      miTienda.body.stores[index].originalStoreName,
                  provinceName: miTienda.body.stores[index].provinceName,
                );
              },
            );
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

  Widget _carruselDeCategorias() {
    return FutureBuilder(
        future: categoryResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              addAutomaticKeepAlives: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.body.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(
                  name: snapshot.data.body.categoryList[index].categoryName,
                  image: snapshot.data.body.categoryList[index].iconUrl,
                  color: snapshot.data.body.categoryList[index].hexColor,
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
        });
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

  Future<CategoryResponseModel> fetchCategories(BuildContext context) {
    return CategoriesProvider().getAllCategories(context);
  }

  Future<Tiendita> fetchTienditas(BuildContext context) {
    return StoreProvider().getAllTienditas(context);
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      tienditaResponse = fetchTienditas(context);
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    //todo Shimer animation. while is loading
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  getNewCustomAppBar() {
    return SliverAppBar(
      expandedHeight: 150.0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          //Category List Row Container
          height: 110,
          child: _carruselDeCategorias(),
        ),
      ),
    );
  }

  getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: azulTema,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 275,
              decoration: BoxDecoration(
                color: grisClaroTema,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                onSubmitted: (value) {
                  if (value.length > 0) {
                    Navigator.pushNamed(context, 'search_for_store',
                        arguments: value.toLowerCase());
                  }
                },
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                enabled: true,
                cursorColor: azulTema,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'Buscar Tienda',
                  hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTiendasStoreList() {
    FutureBuilder(
      future: tienditaResponse,
      builder: (
        BuildContext context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          Tiendita miTienda = snapshot.data;
          List<StoreCardWidget> newListOfCards;
          miTienda.body.stores.forEach((tienda) {
            newListOfCards.add(
              StoreCardWidget(
                name: tienda.storeName,
                handle: tienda.storeTagName,
                category: tienda.categoryName,
                colorHex: tienda.hexColor,
                image: tienda.iconUrl,
                description: tienda.description,
                followers: 12,
                originalStoreName: tienda.originalStoreName,
                provinceName: tienda.provinceName,
              ),
            );
          });
          return newListOfCards.first;
        } else {
          return Container();
        }
      },
    );
  }

  Color getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
