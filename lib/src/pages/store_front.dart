import 'package:app_tiendita/src/modelos/store_model.dart';
import 'package:app_tiendita/src/providers/tiendas_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/crearCategoryList.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreFrontPage extends StatefulWidget {
  @override
  _StoreFrontPageState createState() => _StoreFrontPageState();
}

class _StoreFrontPageState extends State<StoreFrontPage> {
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
                  height: screenHeight *.25,
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
                      Navigator.pushNamed(context, 'categories_page');
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: getCategories(),
                  ),
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

//  getTiendas();

//  Widget _swiperTarjetas() {
//    return FutureBuilder(
//        future: peliculasProvider.getEnCines(),
//        builder: (
//            BuildContext context,
//            AsyncSnapshot<List> snapshot,
//            ) {
//          if (snapshot.hasData) {
//            return StoreCardWidget(name: snapshot.,);
//          } else {
//            return Container(
//              height: 400,
//              child: Center(
//                child: CircularProgressIndicator(),
//              ),
//            );
//          }
//        });
//  }

//  ListView(
//  padding: EdgeInsets.symmetric(horizontal: 24),
//  shrinkWrap: true,
//  children: getStoreList(),
//  ),

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
      future: tiendasProvider.getAllTiendas(),
      builder: (
        BuildContext context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          print('aloo');
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.length,
            padding: EdgeInsets.symmetric(horizontal: 24),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Tienda miTienda = snapshot.data[index];
              return StoreCardWidget(
                name: miTienda.name,
                handle: miTienda.handle,
                followers: miTienda.followers,
                image: miTienda.image,
                category: miTienda.category,
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
}
