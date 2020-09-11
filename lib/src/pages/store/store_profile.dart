import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreProfile extends StatefulWidget {
  @override
  _StoreProfileState createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    User userInfo = Provider.of<LoginState>(context).getTienditaUser();
    print("en la vista nueva");
    print(userInfo.stores);
    Tiendita resultTiendita;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Mi Tienda',
          style: appBarStyle,
        ),
      ),
      body: FutureBuilder(
          future: StoreProvider().getStoreInfo(context, userInfo.stores[0]),
          builder: (BuildContext context, snapshot) {
            print("El false ${snapshot.hasData}");
            if (snapshot.hasData) {
              resultTiendita = snapshot.data;
              return Column(
                children: <Widget>[
                  StoreCardWidget(
                    name: resultTiendita.body.store.storeName,
                    handle: resultTiendita.body.store.storeTagName,
                    colorHex: resultTiendita.body.store.hexColor,
                    image: resultTiendita.body.store.iconUrl,
                    category: resultTiendita.body.store.categoryName,
                    followers: null,
                    provinceName: resultTiendita.body.store.provinceName,
                    description: resultTiendita.body.store.description,
                    originalStoreName: resultTiendita.body.store.originalStoreName,
                  ),
                ],
              );
            } else {
              return Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
      ),
    );
  }
}
