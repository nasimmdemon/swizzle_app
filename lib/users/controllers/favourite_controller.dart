import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/model/items.dart';

class FavouriteController extends GetxController {
  final RxBool _isFavourite = false.obs;
  final RxList<Item> _userFavlist = <Item>[].obs;
  bool get isFavourite => _isFavourite.value;
  var currentUser = Get.put(CurrentUser());
  List<Item> get userFavlist => _userFavlist.value;

  fetchUserFavList() async {
    List<Item> listOfFav = [];
    try {
      var res = await http.post(Uri.parse(Api.readUserFavourite), body: {
        "user_id": currentUser.user.user_id.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          for (var element in (resBody['favtList'] as List)) {
            listOfFav.add(Item.fromJson(element));
          }
        }
        _userFavlist.value = listOfFav;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  validateFavourite(int itemId) async {
    try {
      var res = await http.post(Uri.parse(Api.validateFavourite), body: {
        "user_id": currentUser.user.user_id.toString(),
        "item_id": itemId.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);

        if (resBody['success']) {
          _isFavourite(true);
        } else {
          _isFavourite(false);
        }
      } else {
        _isFavourite(false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  addToFavourite(int itemId) async {
    try {
      var res = await http.post(Uri.parse(Api.addToFavourite), body: {
        "user_id": currentUser.user.user_id.toString(),
        "item_id": itemId.toString(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: itemAddedToFavourite);
          _isFavourite(true);
          fetchUserFavList();
        }
      } else {
        Fluttertoast.showToast(msg: serverError);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  removeFromFavourite(int itemId) async {
    try {
      var res = await http.post(Uri.parse(Api.removeFavourite), body: {
        "user_id": currentUser.user.user_id.toString(),
        "item_id": itemId.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: itemRemovedFromFavourite);
          _isFavourite(false);
          fetchUserFavList();
        }
      } else {
        Fluttertoast.showToast(msg: serverError);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
