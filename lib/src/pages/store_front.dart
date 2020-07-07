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
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Lista componentes desde aqui
            //Contenedor del search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              //<<>>
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _searchInput(),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Container(
                      child: Image(height: 35,
                        width: 35,
                        image: AssetImage('assets/images/codigo-qr.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Contenedor de Categorias
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Text('Categorías', style: storeSubtitles),
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
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getCategories(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              margin: EdgeInsets.only(bottom: 10),
              child: Text('Sugerencias para ti', style: storeSubtitles),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24),
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
