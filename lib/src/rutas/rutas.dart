
import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/pages/categories_page.dart';
import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/pages/login_page.dart';
import 'package:app_tiendita/src/pages/place_holder_page.dart';
import 'package:app_tiendita/src/pages/profile.dart';
import 'package:app_tiendita/src/pages/store_items_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'cart': (BuildContext context) => CartPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'store_items_page': (BuildContext context) => StoreItemsPage(),
    'categories_page': (BuildContext context) => CategoriesPage(),
    'login_page': (BuildContext context) => LoginPage(),
    'place_holder_page': (BuildContext context) => PlaceHolderPage(),

  };
}
