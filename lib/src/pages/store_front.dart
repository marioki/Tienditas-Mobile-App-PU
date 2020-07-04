import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/crearCategoryList.dart';
import 'package:app_tiendita/src/utils/crearListaDeTiendas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreFrontPage extends StatefulWidget {
  @override
  _StoreFrontPageState createState() => _StoreFrontPageState();
}

class _StoreFrontPageState extends State<StoreFrontPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //padding: EdgeInsets.all(20),
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
              trailing: FlatButton(
                onPressed: () {},
                child: Text(
                  'Ver Todas',
                  style: storeOptions,
                ),
              ),
            ),
            Container(
              //Category List Row Container
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 0),
              height: 155,
              child: ListView(
                  scrollDirection: Axis.horizontal, children: getCategories()),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('Sugerencias para ti', style: storeSubtitles),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: getStoreList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Expanded(
      child: TextField(
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
          hintText: 'Buscar',
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


}
