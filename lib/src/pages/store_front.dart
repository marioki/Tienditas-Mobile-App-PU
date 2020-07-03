import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/crearCategoryList.dart';
import 'package:flutter/material.dart';

class StoreFrontPage extends StatefulWidget {
  @override
  _StoreFrontPageState createState() => _StoreFrontPageState();
}

class _StoreFrontPageState extends State<StoreFrontPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          //Lista componentes desde aqui
          //Contenedor del search bar
          Container(
            //<<>>
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _searchInput(),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.dashboard,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          //Contenedor de Categorias
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Text('Categorias', style: storeSubtitles),
            trailing: Text('Ver Todas'),
          ),
          Container(
            //Category List Row Container
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0),
            height: 155,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getCategories()),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text('Sugerencias para ti', style: storeSubtitles),
          ),
          Container(
            height: 400,
            child: ListView(
              shrinkWrap: true,
              children: _getStoresList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Search here...',
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

//  InputDecoration(
//  border: OutlineInputBorder(
//  borderRadius: BorderRadius.circular(50),
//  ),
//  hintText: ('Buscar comercios'),
//  labelText: 'Buscar Comercios',

  Widget _crearStoreCard() {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, 'store_items_page');
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        color: rosadoClaro,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/google_icon.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('MakeupLove Store', style: storeTitleCardStyle),
                    Text('@makeuplove.store', style: storeDetailsCardStyle),
                    Text('Seguidores:3,200', style: storeDetailsCardStyle),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//  List<Widget> _getCategoriesList(int cantidad) {
//    List<Widget> categoryCardList = List();
//
//    for (int i = 0; i < cantidad; i++) {
//      final categoryCard = _createCategoriaCard();
//      categoryCardList.add(categoryCard);
//    }
//
//    return categoryCardList;
//  }

  List<Widget> _getStoresList() {
    return [
      _crearStoreCard(),
      _crearStoreCard(),
      _crearStoreCard(),
      _crearStoreCard(),
      _crearStoreCard(),
      _crearStoreCard(),
    ];
  }
}
