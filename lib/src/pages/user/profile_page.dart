import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/store/create_store.dart';
import 'package:app_tiendita/src/pages/store/store_profile.dart';
import 'package:app_tiendita/src/pages/user/edit_user_profile.dart';
import 'package:app_tiendita/src/pages/user/user_address_page.dart';
import 'package:app_tiendita/src/pages/user/user_bank_accounts.dart';
import 'package:app_tiendita/src/pages/user/user_batch_page.dart';
import 'package:app_tiendita/src/pages/user/user_payment_method_page.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/my_profile_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      Provider.of<LoginState>(context).reloadUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserTienditas userInfo = Provider.of<LoginState>(context).getTienditaUser();
    var image;
    if (Provider.of<LoginState>(context).getFireBaseUser().photoURL == null) {
      image = Image.asset('assets/images/icons/tienda.png');
    } else {
      image = Provider.of<LoginState>(context).getFireBaseUser().photoURL;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Mi Perfil',
          style: appBarStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/icons/tienda.png'),
            padding: EdgeInsets.only(right: 16.0),
            onPressed: () {
              if (userInfo.stores.length > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreProfile(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateStore(),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyProfileWidget(
                    name: (userInfo.name != null) ? userInfo.name : "",
                    email: userInfo.userEmail,
                    phoneNumber: userInfo.phoneNumber,
                    image: image,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserProfile(
                            user: userInfo,
                          ),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: (userInfo.stores.length > 0)
                        ? "Mi Tienda"
                        : 'Crear Tienda',
                    imageName: "tienda",
                    onPressed: () {
                      if (userInfo.stores.length > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreProfile(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateStore(),
                          ),
                        );
                      }
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Mis Ordenes",
                    imageName: "orders",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBatchPage(
                            userEmail: userInfo.userEmail,
                          ),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Mis Direcciones",
                    imageName: "navegador",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserAddressPage(),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Métodos de Pago",
                    imageName: "pago",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserPaymentMethod(),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Cuentas Bancarias",
                    imageName: "cuenta_bancaria",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBankAccountsPage(),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Ayuda",
                    imageName: "ayuda",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoPage(),
                        ),
                      );
                    },
                  ),
                  UserProfileActionBtn(
                    text: "Cerrar Sesión",
                    imageName: "logout",
                    onPressed: () {
                      Provider.of<LoginState>(context).logout();
                      print("Logout");
                    },
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.sync(() => null);
  }
}

class UserProfileActionBtn extends StatelessWidget {
  UserProfileActionBtn({this.text, this.imageName, this.onPressed});

  final String text;
  final String imageName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Image(
              height: 30,
              width: 30,
              image: AssetImage(
                'assets/images/icons/$imageName.png',
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              '$text',
              style: TextStyle(
                color: azulTema,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
