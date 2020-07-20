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
  void initState() {
    super.initState();
    //userTokenId =
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Lista componentes desde aqui
            //Custom App Bar==========
            CustomScrollView(
              primary: false,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  backgroundColor: azulTema,
                  //pinned: true,
                  floating: true,
                  expandedHeight: 120.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Basic Slivers'),
                  ),
                ),
              ],
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
              if (index == miTienda.body.stores.length - 1) {
                return Column(
                  children: <Widget>[
                    StoreCardWidget(
                      name: miTienda.body.stores[index].storeName,
                      handle: miTienda.body.stores[index].storeTagName,
                      category: miTienda.body.stores[index].categoryName,
                      colorHex: miTienda.body.stores[index].hexColor,
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

  _crearEmailInput() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        color: grisClaroTema,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: 'Escribe tu email',
            hintStyle: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey,
              fontSize: 13,
            )),
      ),
    );
  }
}
