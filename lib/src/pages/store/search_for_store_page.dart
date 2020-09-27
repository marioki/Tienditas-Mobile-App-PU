import 'package:app_tiendita/src/modelos/store/tiendita_model.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';

class SearchForStorePage extends StatefulWidget {
  @override
  _SearchForStorePageState createState() => _SearchForStorePageState();
}

class _SearchForStorePageState extends State<SearchForStorePage> {
  bool inSearchPage = false;
  String userInput;

  @override
  Widget build(BuildContext context) {
    String _userInputFromHome;
    if (!inSearchPage) {
      _userInputFromHome = ModalRoute.of(context).settings.arguments;
      userInput = _userInputFromHome;
    }
    Tiendita resultTiendita;
    return Container(
      color: azulTema,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: getCustomAppBar(),
          body: FutureBuilder(
            future: StoreProvider().getTienditasByNameOrTag(context, userInput),
            builder: (
              BuildContext context,
              snapshot,
            ) {
              if (snapshot.hasData) {
                resultTiendita = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        itemCount: resultTiendita.body.stores.length,
                        itemBuilder: (context, index) {
                          return StoreCardWidget(
                            name: resultTiendita.body.stores[index].storeName,
                            handle:
                                resultTiendita.body.stores[index].storeTagName,
                            colorHex:
                                resultTiendita.body.stores[index].hexColor,
                            image: resultTiendita.body.stores[index].iconUrl,
                            category:
                                resultTiendita.body.stores[index].categoryName,
                            followers: null,
                            provinceName:
                                resultTiendita.body.stores[index].provinceName,
                            description:
                                resultTiendita.body.stores[index].description,
                            originalStoreName: resultTiendita
                                .body.stores[index].originalStoreName,
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  getCustomAppBar() {
    return AppBar(
      toolbarHeight: 100,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35))),
      centerTitle: true,
      backgroundColor: azulTema,
      title: Container(
        width: 275,
        decoration: BoxDecoration(
          color: grisClaroTema,
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextFormField(
          controller: TextEditingController(text: userInput),
          onFieldSubmitted: (_userInput) {
            if (_userInput.length > 0) {
              setState(() {
                inSearchPage = true;
                userInput = _userInput.toLowerCase();
              });
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
    );
  }
}
