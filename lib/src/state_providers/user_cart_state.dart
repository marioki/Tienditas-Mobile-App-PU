import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];

  void addProductoToCart(ProductElement productElement){
    if(cartItemsIds.contains(productElement.itemId)){
      print('El producto ya esta en la canasta! awe');
      return;
    }
    cartProductList.add(productElement);
    cartItemsIds.add(productElement.itemId);
    notifyListeners();
    //Todo agregar el producto al carrto
  }

  void deleteProductFromCart(){
    //Todo Eliminar el Producto del carrito
  }

  void deleteAllCartItems(){
    //Todo Borrar todos los productos del carrito
  }
}