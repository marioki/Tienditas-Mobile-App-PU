import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewStoreFront extends StatefulWidget {
  @override
  _NewStoreFrontState createState() => _NewStoreFrontState();
}

class _NewStoreFrontState extends State<NewStoreFront> {
  CategoryModel myCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Todo: use sliver to box, sliverFillRemaining and Sliver list with custom activity cards widgets
      //https://www.youtube.com/watch?v=k2v3gxtMlDE
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          //My Sliver AppBar==================
          createSliverAppBar(),
          //Categories Labels==================
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  leading: Text('Categorías', style: storeSubtitles),
                  trailing: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'categories_page',
                          arguments: myCategory);
                    },
                    child: Text(
                      'Ver Todas',
                      style: storeOptions,
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          //====================
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  //Category List Row Container
                  height: 110,
                  child: _carruselDeCategorias(),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(bottom: 10, top: 16),
                child: Text('Sugerencias para ti', style: storeSubtitles),
              );
            }, childCount: 1),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Expanded(
                  child: getTiendasListViewBuilder(),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  _carruselDeCategorias() {
    return FutureBuilder(
        future: CategoriesProvider().getAllCategories(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            myCategory = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myCategory.body.category.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(
                  name: myCategory.body.category[index].categoryName,
                  image: myCategory.body.category[index].iconUrl,
                  color: myCategory.body.category[index].hexColor,
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

  getTiendasListViewBuilder() {
    print('LLamada del metodo');
    return FutureBuilder(
      future: StoreProvider().getAllTienditas(context),
      builder: (
        BuildContext context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          print('aloo');
          print(snapshot.data);
          Tiendita miTienda = snapshot.data;
          return ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
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
                      description: null,
                      provinceName: null,
                      originalStoreName: null,
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
                description: null,
                provinceName: null,
                originalStoreName: null,
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
    );
  }


  Widget createSearchAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      centerTitle: true,
      bottom: AppBar(
        title: Container(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5, left: 15),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('sesarch');
                },
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "What are you looking for ?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        elevation: 20,
      ),
    );
  }

  Widget createSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: azulTema,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: <Widget>[
            SizedBox(height: 90.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(46.0, 6.0, 46.0, 16.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                child: CupertinoTextField(
                  keyboardType: TextInputType.text,
                  placeholder: 'Buscar tiendita',
                  placeholderStyle: TextStyle(
                    color: Color(0xffC4C6CC),
                    fontSize: 14.0,
                    fontFamily: 'Nunito',
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xffC4C6CC),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Color(0xffF0F1F5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
