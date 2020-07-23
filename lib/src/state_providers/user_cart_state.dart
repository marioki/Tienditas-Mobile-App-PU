import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  double totalPrice = 0;
  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];

  void addProductoToCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemName)) {
      print('El producto ya esta en la canasta! awe');
      return;
    } else {
      cartProductList.add(productElement);
      cartItemsIds.add(productElement.itemName);
      calculateTotalPriceOfCart();
      notifyListeners();
    }
  }

  void deleteProductFromCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemName)) {
      cartProductList.removeWhere(
          (element) => element.itemName == productElement.itemName);
      cartItemsIds.remove(productElement.itemName);
      calculateTotalPriceOfCart();
      notifyListeners();
    } else {
      print('El producto no esta en el carrito!');
    }
  }

  void addProductItemQuantity(String itemName) {
    //Todo implement cantidad de un item y calcular el precio despues
    int index = cartItemsIds.indexOf(itemName);
    print(index);
  }

  double calculateTotalPriceOfCart() {
    //Todo Money format
    double _totalPrice = 0;
    cartProductList.forEach((element) {
      _totalPrice += double.parse(element.finalPrice).roundToDouble();
    });
    totalPrice = _totalPrice;
    print(totalPrice);
    notifyListeners();
    return totalPrice;
  }

  void deleteAllCartItems() {
    //Todo Borrar todos los productos del carrito
    cartProductList.clear();
    cartItemsIds.clear();
  }
}
