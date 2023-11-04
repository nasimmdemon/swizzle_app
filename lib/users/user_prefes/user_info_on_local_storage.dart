import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swizzle/users/screens/Auth/login_screen.dart';

import '../../consts/consts.dart';
import '../model/user.dart';
import '../screens/dashboard_screen.dart';

class UserPrefes {
  //! Save User Data To the Local Storage starts here
  static Future<void> rememberUserPrefes(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userData.toJson());
    await prefs.setString('currentUser', userJsonData);
    Fluttertoast.showToast(msg: '$welcome ${userData.user_name}');
    Get.offAll(() => DashboardScreen());
  }
  //! Save user To Local Storage ends here

  //! Restore user from Local Storage starts here
  static Future<User?> readUserPrefes() async {
    User? currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJsonData = prefs.getString('currentUser');
    if (userJsonData != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userJsonData);
      currentUser = User.fromJson(userDataMap);
      return currentUser;
    }
    return null;
  }
  //! Restore user from Local Storage ends here

  //! Clear data from local storage starts here
  static Future clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(const LoginScreen());
  }
  //! Clear data from local storage ends here
}
