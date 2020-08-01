import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/tiendita_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreFrontPage extends StatefulWidget {
  @override
  _StoreFrontPageState createState() => _StoreFrontPageState();
}

class _StoreFrontPageState extends State<StoreFrontPage> {
  CategoryModel myCategory;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: azulTema,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: getCustomAppBar(),
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Lista componentes desde aqui
              //Custom App Bar ==========
              //Contenedor de Categorias
              ListTile(
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
              ),
              Container(
                //Category List Row Container
                height: 110,
                child: _carruselDeCategorias(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(bottom: 10, top: 16),
                child: Text('Sugerencias para ti', style: storeSubtitles),
              ),
              Expanded(
                child: getTiendasListViewBuilder(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTiendasListViewBuilder() {
    print('LLamada del metodo');
    return FutureBuilder(
      future: TienditasProvider().getAllTienditas(context),
      builder: (
        BuildContext context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          print('aloo');
          print(snapshot.data);
          Tiendita miTienda = snapshot.data;
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
                      description: miTienda.body.stores[index].description,
                      followers: null,
                      originalStoreName:
                          miTienda.body.stores[index].originalStoreName,
                      provinceName: miTienda.body.stores[index].provinceName,
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
    );
  }

  Widget _carruselDeCategorias() {
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
              child: TextFormField(
                onFieldSubmitted: (value) {
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
}
