
import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/pages/profile.dart';
import 'package:app_tiendita/src/pages/store_items_page.dart';
import 'package:app_tiendita/src/pages/store_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'cart': (BuildContext context) => CartPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'store_page': (BuildContext context) => StorePage(),
    'store_items_page': (BuildContext context) => StoreItemsPage(),

  };
}
