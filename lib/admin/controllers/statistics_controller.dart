import 'dart:convert';

import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;

class StatisticsController extends GetxController {
  RxInt totalCustomers = 0.obs;
  RxInt totalOrders = 0.obs;
  RxInt revinew = 0.obs;

  Future totalUsers() async {
    try {
      var response = await http.post(Uri.parse(Api.totalCustomers));
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          totalCustomers.value = int.parse(resBody['totalCustomers']);
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  Future totalOrdersMet() async {
    try {
      var response = await http.post(Uri.parse(Api.totalOrders));
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          totalOrders.value = int.parse(resBody['totalOrders']);
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  Future totalRevinew() async {
    try {
      var response = await http.post(Uri.parse(Api.totalOrders));
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          revinew.value = int.parse(resBody['totalAmounts']);
        }
      }
    } catch (error) {
      rethrow;
    }
  }
}
