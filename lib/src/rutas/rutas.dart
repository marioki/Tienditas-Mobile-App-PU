import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/pages/categories_page.dart';
import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/pages/login_page.dart';
import 'package:app_tiendita/src/pages/user/profile_page.dart';
import 'package:app_tiendita/src/pages/store/search_for_store_page.dart';
import 'package:app_tiendita/src/pages/store/store_items_page.dart';
import 'package:app_tiendita/src/pages/store/stores_by_category.dart';
import 'package:app_tiendita/src/pages/store/store_profile.dart';
import 'package:flutter/material.dart';

class Rutas extends StatefulWidget {
  @override
  _RutasState createState() => _RutasState();
}

class _RutasState extends State<Rutas> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Map<String, WidgetBuilder> getApplicationRoutes(bool loggedIn) {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'cart': (BuildContext context) => CartPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'store_items_page': (BuildContext context) => StoreItemsPage(),
    'categories_page': (BuildContext context) => CategoriesPage(),
    'login_page': (BuildContext context) => LoginPage(),
    'stores_by_category': (BuildContext context) => StoresByCategory(),
    'search_for_store': (BuildContext context) => SearchForStorePage(),
    '/store_profile': (BuildContext context) => StoreProfile(),
  };
}
