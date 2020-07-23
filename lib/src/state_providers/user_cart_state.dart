import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
    int index = cartItemsIds.indexOf(itemName);
    print('product index $index');
    cartProductList[index].cartItemAmount++;
    print('price: ${cartProductList[index].cartItemAmount}');
    calculateTotalPriceOfCart();
    notifyListeners();
  }

  void subtractProductItemQuantity(String itemName) {
    int index = cartItemsIds.indexOf(itemName);
    int itemAmount = cartProductList[index].cartItemAmount;
    if (itemAmount > 1) {
      print('product index $index');
      cartProductList[index].cartItemAmount--;
      print('price: ${cartProductList[index].cartItemAmount}');
      calculateTotalPriceOfCart();
      notifyListeners();
    } else {
      print('Minimo de 1 por producto');
    }
  }

  int getItemAmountInCart(String itemName) {
    int index = cartItemsIds.indexOf(itemName);
    int itemAmount = cartProductList[index].cartItemAmount;
    return itemAmount;
  }

  calculateTotalPriceOfCart() {
    //Todo Money format
    double _totalPrice = 0;
    cartProductList.forEach((element) {
      _totalPrice += double.parse(element.finalPrice).roundToDouble() *
          element.cartItemAmount;
    });
    totalPrice = _totalPrice;
    print(totalPrice);
    notifyListeners();
  }

  void deleteAllCartItems() {
    //Todo Borrar todos los productos del carrito
    cartProductList.clear();
    cartItemsIds.clear();
  }
}
