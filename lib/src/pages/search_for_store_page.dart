import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/providers/buscar_tienda_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchForStorePage extends StatefulWidget {
  @override
  _SearchForStorePageState createState() => _SearchForStorePageState();
}

class _SearchForStorePageState extends State<SearchForStorePage> {
  String userInput = '';

  @override
  Widget build(BuildContext context) {
    Tiendita resultTiendita;
    List<Store> listaTiendas;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: TextField(
            decoration: InputDecoration(),
            onSubmitted: (_userInput) {
              if (_userInput.length > 0) {
                setState(() {
                  userInput = _userInput;
                });
              }
            },
            autofocus: true,
          ),
        ),
        body: FutureBuilder(
          future: BuscarTienditasProvider()
              .getTienditasByNameOrTag(context, userInput),
          builder: (
            BuildContext context,
            snapshot,
          ) {
            if (snapshot.hasData) {
              resultTiendita = snapshot.data;
              return ListView.builder(
                itemCount: resultTiendita.body.stores.length,
                itemBuilder: (context, index) {
                  return StoreCardWidget(
                    name: resultTiendita.body.stores[index].storeName,
                    handle: resultTiendita.body.stores[index].storeTagName,
                    colorHex: resultTiendita.body.stores[index].hexColor,
                    image: resultTiendita.body.stores[index].iconUrl,
                    category: resultTiendita.body.stores[index].categoryName,
                    followers: null, //todo Followers desde backend Facebook api
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
