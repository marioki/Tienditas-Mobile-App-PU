import 'package:app_tiendita/src/modelos/banner_model.dart';
import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/providers/banner_provider.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreFrontPage extends StatefulWidget {
  @override
  _StoreFrontPageState createState() => _StoreFrontPageState();
}

class _StoreFrontPageState extends State<StoreFrontPage> {
  Future<CategoryResponseModel> categoryResponse;
  Future<Tiendita> tienditaResponse;
  Future<BannerResponseModel> bannerResponse;

  @override
  void initState() {
    super.initState();
    setState(() {
      tienditaResponse = fetchTienditas(context);
      categoryResponse = fetchCategories(context);
      bannerResponse = fetchBanners(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        return _onBackPressed(context);
      },
      child: Container(
        color: azulTema,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: getCustomAppBar(),
            resizeToAvoidBottomInset: false,
            body: RefreshIndicator(
              onRefresh:() => _onRefresh(),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  //Lista componentes desde aqui
                  //Custom App Bar ==========
                  //Contenedor de Banners
                  getBanners(),
                  //Contenedor de Categorias
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Text('Categorías', style: storeSubtitles),
                    trailing: FlatButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, 'categories_page',
                            arguments: await categoryResponse);
                      },
                      child: Text(
                        'Ver Todas',
                        style: storeOptions,
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: _carruselDeCategorias(),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => SliverStoreFront(),));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(bottom: 10, top: 16),
                      child: Text('Sugerencias para ti', style: storeSubtitles),
                    ),
                  ),
                  FutureBuilder(
                    future: tienditaResponse,
                    builder: (
                      BuildContext context,
                      snapshot,
                    ) {
                      if (snapshot.hasData) {
                        Tiendita miTienda = snapshot.data;
                        return ListView.builder(
                          primary: false,
                          itemCount: miTienda.body.stores.length,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == miTienda.body.stores.length - 1) {
                              return Column(
                                children: <Widget>[
                                  StoreCardWidget(
                                    name: miTienda.body.stores[index].storeName,
                                    handle: miTienda
                                        .body.stores[index].storeTagName,
                                    category: miTienda
                                        .body.stores[index].categoryName,
                                    colorHex:
                                        miTienda.body.stores[index].hexColor,
                                    image: miTienda.body.stores[index].iconUrl,
                                    description:
                                        miTienda.body.stores[index].description,
                                    followers: null,
                                    originalStoreName: miTienda
                                        .body.stores[index].originalStoreName,
                                    provinceName: miTienda
                                        .body.stores[index].provinceName,
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
                              category:
                                  miTienda.body.stores[index].categoryName,
                              colorHex: miTienda.body.stores[index].hexColor,
                              image: miTienda.body.stores[index].iconUrl,
                              description:
                                  miTienda.body.stores[index].description,
                              followers: null,
                              originalStoreName:
                                  miTienda.body.stores[index].originalStoreName,
                              provinceName:
                                  miTienda.body.stores[index].provinceName,
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBanners() {
    return FutureBuilder(
        future: bannerResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            BannerResponseModel banner = snapshot.data;
            final List<Widget> imageSliders = banner.body.bannerList
                .map((item) => Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: GestureDetector(
                              onTap: () {
                                if (item.link != null) {
                                  _launchURL(item.link);
                                }
                              },
                              child: Stack(
                                children: <Widget>[
                                  Image.network(item.imageUrl,
                                      fit: BoxFit.cover, width: 1000.0),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${item.title}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${item.description}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ))
                .toList();
            return _carouselBanner(imageSliders);
          } else
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }

  _launchURL(String linkUrl) async {
    var url = linkUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Widget getTiendasListViewBuilder() {
  //   return SmartRefresher(
  //     physics: BouncingScrollPhysics(),
  //     enablePullDown: true,
  //     enablePullUp: true,
  //     header: WaterDropHeader(
  //       complete: Text('¡Actualizado!'),
  //     ),
  //     footer: CustomFooter(
  //       builder: (BuildContext context, LoadStatus mode) {
  //         Widget body;
  //         if (mode == LoadStatus.idle) {
  //           //body = Text("pull up load");
  //         } else if (mode == LoadStatus.loading) {
  //           body = CupertinoActivityIndicator();
  //         } else if (mode == LoadStatus.failed) {
  //           body = Text("Error de conexión...");
  //         } else if (mode == LoadStatus.canLoading) {
  //           // body = Text("release to load more");
  //         } else {
  //           //body = Text("No more Data");
  //         }
  //         return Container(
  //           height: 55.0,
  //           child: Center(child: body),
  //         );
  //       },
  //     ),
  //     controller: _refreshController,
  //     onRefresh: _onRefresh,
  //     onLoading: _onLoading,
  //   );
  // }

  Widget _carruselDeCategorias() {
    return FutureBuilder(
        future: categoryResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              primary: true,
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

  Widget _carouselBanner(List<Widget> banners) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: banners,
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

  Future<BannerResponseModel> fetchBanners(BuildContext context) {
    return BannersProvider().getAllBanners(context);
  }

  Future<Tiendita> fetchTienditas(BuildContext context) {
    return StoreProvider().getAllTienditas(context);
  }

  Future<void> _onRefresh() async {
    // monitor network fetch
    setState(() {
      tienditaResponse = fetchTienditas(context);
    });

    // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    //todo Shimer animation. while is loading
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
  }
}
