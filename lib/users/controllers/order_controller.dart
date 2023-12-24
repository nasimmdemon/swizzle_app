import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/model/order.dart';

class OrderController extends GetxController {
  var needRefresh = false;
  var currentUser = Get.find<CurrentUser>();

  Future<List<Order>> getUserOrderDetails() async {
    List<Order> orders = [];
    var res = await http.post(Uri.parse(Api.readOrderInfo),
        body: {'user_id': currentUser.user.user_id.toString()});

    if (res.statusCode == 200) {
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        for (var singleOrder in (resBody['orderList'] as List)) {
          orders.add(Order.fromJson(singleOrder));
        }
      }
    }

    return orders;
  }

  Future<List<Order>> getCompletedOrderDetails() async {
    List<Order> orders = [];
    var res = await http.post(Uri.parse(Api.readCompletedOrderInfo),
        body: {'user_id': currentUser.user.user_id.toString()});

    if (res.statusCode == 200) {
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        for (var singleOrder in (resBody['orderList'] as List)) {
          orders.add(Order.fromJson(singleOrder));
        }
      }
    }

    return orders;
  }

  void makeSmallRefresh() {
    needRefresh = true;
    Future.delayed(const Duration(seconds: 3), () {
      needRefresh = false;
    });
  }

  Future cancelOrder(int orderId) async {
    try {
      var res = await http.post(Uri.parse(Api.cancelOrder), body: {
        'order_id': orderId.toString(),
      });

      print(res.body);

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);

        if (resBody['success']) {
          Get.back();
          makeSmallRefresh();
          Fluttertoast.showToast(msg: theOrderIsCanceled);
        } else {
          Fluttertoast.showToast(msg: serverError);
        }
      }
    } catch (error) {
      Fluttertoast.showToast(msg: serverError);
      rethrow;
    }
  }
}
