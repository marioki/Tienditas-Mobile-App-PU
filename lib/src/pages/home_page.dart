import 'package:app_tiendita/src/pages/store_front.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedLabelStyle: navBarLabelStyle,
      selectedIconTheme: IconThemeData(color: azulOscuro),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('Cart'),
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          title: Text('Profile'),
          icon: Icon(Icons.account_circle),
        ),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return StoreFrontPage();
      case 1:
        return CartPage();
      case 2:
        return ProfilePage();

      default:
        return StoreFrontPage();
    }
  }
}
