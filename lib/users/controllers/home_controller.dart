import 'dart:convert';

import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/controllers/favourite_controller.dart';
import 'package:swizzle/users/model/items.dart';

class HomeController extends GetxController {
  final RxList<Item> _flashSaleProducts = <Item>[].obs;
  final RxList<Item> _latestProduct = <Item>[].obs;
  final RxList<Item> _searchItems = <Item>[].obs;
  final RxList _sliderItems = [].obs;
  RxBool searcing = false.obs;
  var screenIndex = 0.obs;
  var shimmer = true.obs;

  List<Item> get flashSaleProducts => _flashSaleProducts.value;
  List<Item> get latestProduct => _latestProduct.value;
  List<Item> get searchItems => _searchItems.value;
  List get sliderItems => _sliderItems.value;

  fireSearch(String keyword) async {
    _searchItems.clear();
    List<Item> searchedItems = [];
    try {
      searcing(true);
      var res = await http.post(Uri.parse(Api.itemSearch), body: {
        "keyword": keyword.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          for (var element in (resBody['searchList'] as List)) {
            searchItems.add(Item.fromJson(element));
          }
        }
        _searchItems.value = searchItems;
        searcing(false);
      } else {
        searcing(false);
      }
    } catch (e) {
      searcing(false);
      print(e.toString());
    }
  }

  changeShimmerStatus() {
    Future.delayed(const Duration(seconds: 7), () {
      shimmer(false);
      var favController = Get.put(FavouriteController());
      favController.fetchUserFavList();
    });
  }

  getFlashSaleProducts() async {
    List<Item> flashSaleProducts = [];

    try {
      var res = await http.post(Uri.parse(Api.flashSaleItems));

      if (res.statusCode == 200) {
        var resData = jsonDecode(res.body);
        if (resData['success']) {
          for (var item in (resData['items'] as List)) {
            flashSaleProducts.add(Item.fromJson(item));
          }
        }
      }

      _flashSaleProducts.value = flashSaleProducts;
    } catch (e) {
      print(e.toString());
    }

    return flashSaleProducts;
  }

  getLatstProducts() async {
    List<Item> latestProduct = [];

    try {
      var res = await http.post(Uri.parse(Api.latestItems));

      if (res.statusCode == 200) {
        var resData = jsonDecode(res.body);
        if (resData['success']) {
          for (var item in (resData['items'] as List)) {
            latestProduct.add(Item.fromJson(item));
          }
        }
      }

      _latestProduct.value = latestProduct;
    } catch (e) {
      print(e.toString());
    }

    _latestProduct.value = latestProduct;
  }

  sliderImageFetch() async {
    List items = [];
    try {
      var res = await http.post(Uri.parse(Api.sliderImages));
      var resBody = jsonDecode(res.body);
      if (resBody['success']) {
        for (var element in (resBody['items'] as List)) {
          items.add(element);
        }
        _sliderItems.value = items;
      }
    } catch (e) {
      print(e.toString());
    }
    _sliderItems.value = items;
  }
}
