import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];

  void addProductoToCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemName)) {
      print('El producto ya esta en la canasta! awe');
      return;
    } else {
      cartProductList.add(productElement);
      cartItemsIds.add(productElement.itemName);
      notifyListeners();
    }
  }

  void deleteProductFromCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemName)) {
      cartProductList.removeWhere(
          (element) => element.itemName == productElement.itemName);
      cartItemsIds.remove(productElement.itemName);
      notifyListeners();
    } else {
      print('El producto no esta en el carrito!');
    }
  }

  void deleteAllCartItems() {
    //Todo Borrar todos los productos del carrito
  }
}
