import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/model/cart.dart';

class CartController extends GetxController {
  final RxDouble _grandTotal = 0.0.obs;
  final RxList<Cart> _cartList = <Cart>[].obs;
  final RxList<int> _selectedItem = <int>[].obs;
  final RxBool _isSelectedAll = false.obs;

  double get grandTotal => _grandTotal.value;
  List get cartList => _cartList.value;
  List get selectedItem => _selectedItem.value;
  bool get isSelectedAll => _isSelectedAll.value;

  setCartList(List<Cart> userCartList) {
    _cartList.value = userCartList;
    update();
  }

  removeFromCart(int userId) {
    for (var element in cartList) {
      if (selectedItem.contains(element.item_id)) {
        removeSingleCart(element.cart_id, userId);
        removeAllSelectedItem();
        update();
      }
    }
  }

  addSelectedItem(int itemId) {
    if (!selectedItem.contains(itemId)) {
      selectedItem.add(itemId);
      if (selectedItem.length == cartList.length) {
        _isSelectedAll(true);
        calculateTotalPrice();
        update();
      }
      calculateTotalPrice();
      update();
    }
  }

  removeSelectedItem(int itemId) {
    _isSelectedAll(false);
    selectedItem.removeWhere((element) => element == itemId);
    calculateTotalPrice();
    update();
  }

  selectAll() {
    _isSelectedAll(true);
    for (var element in cartList) {
      selectedItem.add(element.item_id);
      calculateTotalPrice();
      update();
    }
  }

  removeAllSelectedItem() {
    _isSelectedAll(false);
    selectedItem.clear();
    calculateTotalPrice();
    update();
  }

  setTotal(double overAllTotal) {
    _grandTotal.value = _grandTotal.value + overAllTotal;
  }

  calculateTotalPrice() {
    _grandTotal(0);

    for (var element in cartList) {
      Cart item = element;
      if (selectedItem.contains(item.item_id)) {
        if (item.sale_price == 0) {
          setTotal((item.item_price) * (item.item_qty));
        } else {
          setTotal((item.sale_price) * (item.item_qty));
        }
      }
    }
  }

  reduceCartQuantity(int cartId, int userId) async {
    try {
      var res = await http.post(Uri.parse(Api.reduceCartQuantity), body: {
        "cart_id": cartId.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: quantityUpdated);
          fetchUserCartList(userId);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  removeSingleCart(int cartId, int userId) async {
    try {
      var res = await http.post(Uri.parse(Api.removeSingleCart), body: {
        "cart_id": cartId.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: itemRemoved);
          fetchUserCartList(userId);
          update();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  fetchUserCartList(int userId) async {
    List<Cart> items = [];
    try {
      var res = await http.post(Uri.parse(Api.readUserCart), body: {
        'user_id': userId.toString(),
      });
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        for (var element in (resBody['cartList'] as List)) {
          items.add(Cart.fromJson(element));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    setCartList(items);
  }
}
