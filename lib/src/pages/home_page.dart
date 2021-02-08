import 'package:app_tiendita/src/pages/login_page.dart';
import 'package:app_tiendita/src/pages/store_front.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
import 'user/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      body: _callPage(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          elevation: 30,
          borderOnForeground: true,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: azulTema),
            selectedLabelStyle: TextStyle(color: azulTema),
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text('Inicio'),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Carrito'),
                icon: Badge(
                  child: Icon(Icons.shopping_cart_outlined),
                  badgeContent: Text(
                    Provider.of<UserCartState>(context,listen: true)
                        .getCartItemsQuantity()
                        .toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  showBadge: (Provider.of<UserCartState>(context,listen: true)
                      .getCartItemsQuantity() > 0)? true : false,
                ),
              ),
              BottomNavigationBarItem(
                title: Text('Perfil'),
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return StoreFrontPage();
      case 1:
        return CartPage();
      case 2:
        if (Provider.of<LoginState>(context,listen: true).isAnon()) {
          return LoginPage();
        }
        return ProfilePage();

      default:
        return StoreFrontPage();
    }
  }

  _showDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Listo"),
                onPressed: () {
                  return LoginPage();
                },
              ),
            ],
          );
        });
  }
}
