import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/model/user.dart';
import 'package:http/http.dart' as http;

class ItemController extends GetxController {
  RxInt quantity = 1.obs;
  var currentUser = Get.find<CurrentUser>();

  chechIfItemInCart(int userId, int itemId) async {
    var res = await http.post(Uri.parse(Api.checkIfItemInCart), body: {
      'user_id': userId.toString(),
      'item_id': itemId.toString(),
    });

    if (res.statusCode == 200) {
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        var itemData = resBody['cartData'];
        int cartId = int.parse(itemData[0]['cart_id']);
        updateCart(cartId);
      } else {
        addToCart(itemId);
      }
    }
  }

  updateCart(int cartId) async {
    try {
      var res = await http.post(Uri.parse(Api.updateQuantity), body: {
        'cart_id': cartId.toString(),
        'item_qty': quantity.value.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: quantityUpdated);
        } else {
          Fluttertoast.showToast(msg: somethingWentWrong);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: serverError);
    }
  }

  addToCart(int itemId) async {
    User currentOnlineUser = currentUser.user;
    try {
      var res = await http.post(Uri.parse(Api.addToCart), body: {
        'user_id': currentOnlineUser.user_id.toString(),
        'item_id': itemId.toString(),
        'item_qty': quantity.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: itemAdded);
        }
      } else {
        Fluttertoast.showToast(msg: somethingWentWrong);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: serverError);
    }
  }
}
