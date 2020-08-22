import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserCartState with ChangeNotifier {
  double totalPriceOfItems = 0;
  double _deliveryTotalCost = 0;
  double totalAmountOfBatch;
  double impuesto = 0;
  List<StoreDeliveryInfo> _listOfDeliveryOptions;

  List<ProductElement> cartProductList = [];
  List<String> cartItemsIds = [];
  List<String> allStoreTagsList = [];
  List<String> storeTagsListFiltered = [];

  List<Order> _orderList = List<Order>();
  Batch currentBatch = Batch();

  List<StoreDeliveryInfo> getListOfDeliveryInfo() => _listOfDeliveryOptions;

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

  calculateTotalAmountOfBatch() {
    totalAmountOfBatch = totalPriceOfItems + _deliveryTotalCost;
    impuesto = totalPriceOfItems * 0.07;
    print(impuesto);
    print('Total Amount of Batch: $totalAmountOfBatch');
    totalAmountOfBatch += impuesto;
    print('$totalPriceOfItems + $_deliveryTotalCost');
  }

  setDeliveryTotalCost(double deliveryAmount) {
    _deliveryTotalCost = deliveryAmount;
  }

  generateOrderList() {
    _orderList.clear();
//    double orderAmountCounter = 0;

    for (int orderIndex = 0;
        orderIndex < storeTagsListFiltered.length;
        orderIndex++) {
      double orderAmountCounter = 0;
      _orderList.add(
        Order(
          storeTagName: storeTagsListFiltered[orderIndex],
          elements: List<ProductItem>(),
          amount: '',
        ),
      );
      var deliveryInfo = _listOfDeliveryOptions[orderIndex].deliveryOptions[0];
      _orderList[orderIndex].deliveryOption = BatchOrderDeliveryOption(
          fee: deliveryInfo.fee,
          method: deliveryInfo.method,
          name: deliveryInfo.name);

      for (int itemIndex = 0; itemIndex < cartProductList.length; itemIndex++) {
        if (cartProductList[itemIndex].parentStoreTag ==
            _orderList[orderIndex].storeTagName) {
          _orderList[orderIndex].elements.add(
                ProductItem(
                  itemId: cartProductList[itemIndex].itemId,
                  quantity:
                      cartProductList[itemIndex].cartItemAmount.toString(),
                  productName: cartProductList[itemIndex].itemName,
                  itemPrice:
                      double.parse(cartProductList[itemIndex].finalPrice),
                ),
              );
        }
      }
      _orderList[orderIndex].elements.forEach((productItem) {
        orderAmountCounter += productItem.itemPrice;
        _orderList[orderIndex].amount = orderAmountCounter.toStringAsFixed(2);
      });
    }
    currentBatch.orders = _orderList;

    print('====Lista de Ordenes Creada====');
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

  setDeliveryInfoList(List<StoreDeliveryInfo> listOfDeliveryInfo) {
    _listOfDeliveryOptions = listOfDeliveryInfo;
  }

  setCurrentBatchTotalAmount() {
    currentBatch.totalAmount = totalAmountOfBatch.toStringAsFixed(2);
  }

  setCurrentBatchPaymentMethod() {
    currentBatch.paymentMethod = "tarjeta de crédito";
  }

  setCurrentBatchUserInfo(FirebaseUser firebaseUser) {
    currentBatch.userName = firebaseUser.displayName;
    currentBatch.userEmail = firebaseUser.email;
  }

  setCurrentBatchPhoneNumber() {
    currentBatch.phoneNumber = '67868434';
  }
}
