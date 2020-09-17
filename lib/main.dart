import 'package:app_tiendita/src/pages/cart_page.dart';
import 'package:app_tiendita/src/pages/categories_page.dart';
import 'package:app_tiendita/src/pages/crear_tarjeta_page.dart';
import 'package:app_tiendita/src/pages/delivery_options_page.dart';
import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/pages/login_page.dart';
import 'package:app_tiendita/src/pages/user/profile_page.dart';
import 'package:app_tiendita/src/pages/store/search_for_store_page.dart';
import 'package:app_tiendita/src/pages/store/store_items_page.dart';
import 'package:app_tiendita/src/pages/store/stores_by_category.dart';
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
    //Todo Update Provider package
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
            'stores_by_category': (BuildContext context) => StoresByCategory(),
            'search_for_store': (BuildContext context) => SearchForStorePage(),
            'delivery_options': (BuildContext context) => DeliveryOptionsPage(),
            'create_credit_card': (BuildContext context) => CrearNuevaTarjeta(),
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
