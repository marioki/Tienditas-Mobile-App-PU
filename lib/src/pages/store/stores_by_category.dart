import 'dart:ui';
import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/capitalize.dart';
import 'package:app_tiendita/src/widgets/search_bar_widget.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';

class StoresByCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryElement args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Column(children: <Widget>[
            Text(
              capitalize(args.categoryName),
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Categoria',
              style: TextStyle(fontSize: 10),
            ),
          ]),
        ),
      ),
      body: Column(
        children: <Widget>[
//          CustomScrollView(
//            primary: false,
//            scrollDirection: Axis.vertical,
//            shrinkWrap: true,
//            slivers: <Widget>[
//              SliverAppBar(
//                centerTitle: true,
//                title: Column(
//                  children: <Widget>[
//                    Text(
//                      capitalize(args.categoryName),
//                      style: TextStyle(fontSize: 24),
//                    ),
//                    Text(
//                      'Categoria',
//                      style: TextStyle(fontSize: 10),
//                    ),
//                  ],
//                ),
//
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(30),
//                        bottomRight: Radius.circular(30))),
//                backgroundColor: azulTema,
//                //getColorFromHex(args.hexColor),
//                //pinned: true,
//                floating: true,
//                expandedHeight: 120.0,
//                flexibleSpace: FlexibleSpaceBar(),
//              ),
//            ],
//          ),
          SearchBarWidget(),
          FutureBuilder(
            future: StoreProvider().getTienditasPorCategoria(args.categoryName, context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                Tiendita miTienda = snapshot.data;
                if (miTienda.body.stores.length < 1) {
                  return Center(
                    child: Text('Todavia hay tiendas en esta categoria...'),
                  );
                }
                return ListView.builder(
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
                            followers: null,
                            provinceName:
                                miTienda.body.stores[index].provinceName,
                            originalStoreName:
                                miTienda.body.stores[index].originalStoreName,
                            description:
                                miTienda.body.stores[index].description,
                          ),
                          SizedBox(
                            //Todo Change to media query when store card uses media query
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
                      followers: null,
                      provinceName: miTienda.body.stores[index].provinceName,
                      originalStoreName:
                          miTienda.body.stores[index].originalStoreName,
                      description: miTienda.body.stores[index].description,
                    );
                  },
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error de conexción'),
                  );
                }
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
    );
  }
}
