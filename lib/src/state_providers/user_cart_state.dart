import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  double totalPriceOfItems = 0;
  double _deliveryTotalCost = 0;
  double totalAmountOfBatch;

  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];
  List<String> allStoreTagsList = [];
  List<String> storeTagsListFiltered = [];

  List<Order> _orderList = List<Order>();
  Batch currentBatch = Batch();

  void addProductoToCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemId)) {
      print('El producto ya esta en la canasta! awe');
      return;
    } else {
      allStoreTagsList.add(productElement.parentStoreTag);
      cartProductList.add(productElement);
      cartItemsIds.add(productElement.itemId);
      calculateTotalPriceOfCart();
      notifyListeners();
    }
  }

  void deleteProductFromCart(ProductElement productElement) {
    if (cartItemsIds.contains(productElement.itemId)) {
      allStoreTagsList.remove(productElement.parentStoreTag);
      cartProductList
          .removeWhere((element) => element.itemId == productElement.itemId);
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
      _totalPrice += double.parse(element.finalPrice) * element.cartItemAmount;
    });
    totalPriceOfItems = _totalPrice;
    print(totalPriceOfItems.toStringAsFixed(2));
    notifyListeners();
  }

  void deleteAllCartItems() {
    //Todo Borrar todos los productos del carrito
    cartProductList.clear();
    cartItemsIds.clear();
  }

  List<String> filterParentStoreTagList() {
    storeTagsListFiltered.clear();
    allStoreTagsList.forEach((storeTag) {
      if (!storeTagsListFiltered.contains(storeTag)) {
        storeTagsListFiltered.add(storeTag);
      }
    });
    return storeTagsListFiltered;
  }

  //Limpiar el Batch
  clearCurrentBatch() {
    currentBatch = Batch();
  }

  //Agregar una orden al batch
  addOrderToCurrentBatch(Order order) {
    currentBatch.orders.add(order);
  }

  //agregar informacion general del batch
  addGeneralBatchInfo() {
    currentBatch.totalAmount = totalAmountOfBatch.toString();
//    currentBatch.creditCardId = _creditCardId;
//    currentBatch.paymentMethod = _paymentMethod;
//    currentBatch.userName = firebaseUser.displayName;
//    currentBatch.userEmail = firebase.email;
  }

  calculateTotalAmountOfBatch() {
    totalAmountOfBatch = totalPriceOfItems + _deliveryTotalCost;
    print('Total Amount of Batch: $totalAmountOfBatch');
    print('$totalPriceOfItems + $_deliveryTotalCost');
  }

  setDeliveryTotalCost(double deliveryAmount) {
    _deliveryTotalCost = deliveryAmount;
  }

  generateOrderList() {
    _orderList.clear();
    for (int orderIndex = 0;
        orderIndex < storeTagsListFiltered.length;
        orderIndex++) {
      _orderList.add(Order(
          storeTagName: storeTagsListFiltered[orderIndex],
          elements: List<ProductItem>()));
      for (int itemIndex = 0; itemIndex < cartProductList.length; itemIndex++) {
        if (cartProductList[itemIndex].parentStoreTag ==
            _orderList[orderIndex].storeTagName) {
          _orderList[orderIndex].elements.add(ProductItem(
              itemId: cartProductList[itemIndex].itemId,
              quantity: cartProductList[itemIndex].cartItemAmount.toString()));
        }
      }
    }

    print('====Lista de Ordes Creada====');
    _orderList.forEach((order) {
      print(order.storeTagName);
      print(order.elements.length);
      print('item id:  ${order.elements[0].itemId}');
//      print('item quantity: ${order.elements[0].quantity}');
    });
  }

  setUserAddresToOrders(UserAddress address) {
    _orderList.forEach((order) {
      order.userAddress = address;
    });

    _orderList.forEach((order) {
      print(order.userAddress.referencePoint);
    });
  }

  addUserCreditCardToBatch(creditCardId) {
    currentBatch.creditCardId = creditCardId;
    print('User selected: ${currentBatch.creditCardId}');
  }
}
