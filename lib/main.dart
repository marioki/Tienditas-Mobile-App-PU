import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/pages/categories_page.dart';
import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/pages/login_page.dart';
import 'package:app_tiendita/src/pages/new_login_page.dart';
import 'package:app_tiendita/src/pages/place_holder_page.dart';
import 'package:app_tiendita/src/pages/profile_page.dart';
import 'package:app_tiendita/src/pages/search_for_store_page.dart';
import 'package:app_tiendita/src/pages/store_items_page.dart';
import 'package:app_tiendita/src/pages/stores_by_category.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context) => LoginState(),
      child: ChangeNotifierProvider(
        builder: (BuildContext context) => UserCartState(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) {
              var state = Provider.of<LoginState>(context);
              if (state.isLoggedIn()) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
            'cart': (BuildContext context) => CartPage(),
            'profile': (BuildContext context) => ProfilePage(),
            'store_items_page': (BuildContext context) => StoreItemsPage(),
            'categories_page': (BuildContext context) => CategoriesPage(),
            'login_page': (BuildContext context) => LoginPage(),
            'place_holder_page': (BuildContext context) => PlaceHolderPage(),
            'stores_by_category': (BuildContext context) => StoresByCategory(),
            'search_for_store': (BuildContext context) => SearchForStorePage(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
      ),
    );
  }
}
