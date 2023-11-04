import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/model/user.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';
import '../../Api/api_connection.dart';

class AuthController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  //! Custom Bottom sheets need context and content starts here
  customBottomSheet(context, content) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.heightBox,
              const SizedBox(height: 4, width: 100)
                  .box
                  .color(fontGrey)
                  .makeCentered(),
              30.heightBox,
              content.toString().text.size(16).make(),
              30.heightBox,
            ],
          );
        });
  }

  //! Custom bottom sheet ends here

  //! Methood for signup User starts here
  signupUser(context) async {
    try {
      var res = await http.post(Uri.parse(Api.signUp), body: {
        'user_name': nameController.text.trim(),
        'user_email': emailController.text.trim(),
        'user_password': passwordController.text.trim()
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Get.back();
          loginUser(context);

          //move to login screen
          Fluttertoast.showToast(msg: "$welcome ${nameController.text}");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: serverError);
      print(e);
    }
  }

  //! Methood for signup user is ends here

  //! Validating user email before inserting into the database and checking if it exist already
  validateEmail(context) async {
    try {
      var res = await http.post(Uri.parse(Api.validateEmail), body: {
        "user_email": emailController.text.trim(),
      });

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          customBottomSheet(context, emailAlreadyExits);
        } else {
          Fluttertoast.showToast(msg: pleaseWait);
          signupUser(context);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //! User Email validation ends here

  //! Login User Function starts here
  loginUser(context) async {
    try {
      var res = await http.post(Uri.parse(Api.login), body: {
        "user_email": emailController.text.trim(),
        "user_password": passwordController.text.trim()
      });
      print(res);
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);

        if (resBody['success']) {
          var userData = User.fromJson(resBody['user_data']);
          await UserPrefes.rememberUserPrefes(userData);
        } else {
          return customBottomSheet(context, emailOrPasswordDoesntMatch);
        }
      } else {
        Fluttertoast.showToast(msg: serverError);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: serverError);
      print(e.toString());
    }
  }

  //! Login user function ends here
}
