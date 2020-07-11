import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/store_model.dart';
import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/tiendas_provider.dart';
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
  Category myCategory;

  final tiendasProvider = TiendasProvider();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: azulTema,
      body: SafeArea(
        top: true,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Lista componentes desde aqui
                //Custom App Bar==========
                Container(
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: _searchInput(),
                    ),
                  ),
                  height: screenHeight * .25,
                  decoration: BoxDecoration(
                    color: azulTema,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                  ),
                ),
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
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        toolbarOptions: ToolbarOptions(),
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
          hintText: 'Busca Tiendita',
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
        onChanged: (valor) {
          setState(() {});
        },
      ),
    );
  }

  Widget getTiendasListViewBuilder() {
    print('LLamada del metodo');
    return FutureBuilder(
      future: TienditasProvider().getAllTienditas(),
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
              return StoreCardWidget(
                name: miTienda.body.stores[index].storeName,
                handle: miTienda.body.stores[index].storeTagName,
                category: miTienda.body.stores[index].categoryName,
                colorHex: miTienda.body.stores[index].hexColor,

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
        future: CategoriesProvider().getAllCategories(),
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
}
