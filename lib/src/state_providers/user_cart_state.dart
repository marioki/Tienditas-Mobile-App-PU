import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  double totalPrice = 0;
  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];

  void addProductoToCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemId)) {
      print('El producto ya esta en la canasta! awe');
      return;
    } else {
      cartProductList.add(productElement);
      cartItemsIds.add(productElement.itemId);
      calculateTotalPriceOfCart();
      notifyListeners();
    }
  }

  void deleteProductFromCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemId)) {
      cartProductList.removeWhere(
          (element) => element.itemId == productElement.itemId);
      cartItemsIds.remove(productElement.itemId);
      calculateTotalPriceOfCart();
      notifyListeners();
    } else {
      print('El producto no esta en el carrito!');
    }
  }

  void addProductItemQuantity(String itemId) {
    int index = cartItemsIds.indexOf(itemId);
    print('product index $index');
    cartProductList[index].cartItemAmount++;
    print('amount: ${cartProductList[index].cartItemAmount}');
    calculateTotalPriceOfCart();
    notifyListeners();
  }

  void subtractProductItemQuantity(String itemId) {
    int index = cartItemsIds.indexOf(itemId);
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

  int getItemAmountInCart(String itemId) {
    int index = cartItemsIds.indexOf(itemId);
    int itemAmount = cartProductList[index].cartItemAmount;
    return itemAmount;
  }

  calculateTotalPriceOfCart() {
    //Todo Money format
    double _totalPrice = 0;
    cartProductList.forEach((element) {
      _totalPrice += double.parse(element.finalPrice) *
          element.cartItemAmount;
    });
    totalPrice = _totalPrice;
    print(totalPrice.toStringAsFixed(2));
    notifyListeners();
  }

  void deleteAllCartItems() {
    //Todo Borrar todos los productos del carrito
    cartProductList.clear();
    cartItemsIds.clear();
  }
}