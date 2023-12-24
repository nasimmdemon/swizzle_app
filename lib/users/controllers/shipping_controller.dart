// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/Api/api_connection.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/cart_controller.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/model/coupon.dart';
import 'package:swizzle/users/model/userInfo.dart';
import 'package:http/http.dart' as http;
import 'package:swizzle/users/screens/loading/loading_screen.dart';

import '../model/cart.dart';

class ShippingController extends GetxController {
  var userController = Get.put(CurrentUser());
  RxBool isLoading = false.obs;
  RxBool hasCoupon = false.obs;
  Coupon coupondiscount = Coupon(1, '', 'flat', 0, '11/23/2023', 1);
  var selectedShippingMethod = 0.obs;
  //! The controller starts here
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var fullNameController = TextEditingController();
  var zipCodeController = TextEditingController();
  var addressController = TextEditingController();
  var cityTownController = TextEditingController();
  var contactNumberController = TextEditingController();
  var orderNoteController = TextEditingController();
  var couponCodeController = TextEditingController();
  //! The controllers ends here

  setControllers(UserInfo data) {
    userNameController = TextEditingController(text: data.user_name);
    userEmailController = TextEditingController(text: data.user_email);
    fullNameController = TextEditingController(text: data.full_name);
    zipCodeController = TextEditingController(text: data.zip_code.toString());
    addressController = TextEditingController(text: data.address);
    cityTownController = TextEditingController(text: data.city_town);
    contactNumberController =
        TextEditingController(text: data.contact_number.toString());
  }

  //!Stripe payment processing starts here
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(double amount, List<Cart> products) async {
    await createPaymentIndent(amount, products);
    try {
      var applePay = const PaymentSheetApplePay(merchantCountryCode: 'SE');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: appName,
                  applePay: applePay))
          .then((value) async {
        try {
          await Stripe.instance.presentPaymentSheet();
          await updateUserData();
          await addOrderInfo(selectedItems: products, totalAmount: amount);
          Get.to(() => const LoadingScreen());
          print('success');
        } catch (error) {
          if (error is StripeException) {
            Fluttertoast.showToast(
              msg: error.error.localizedMessage.toString(),
              backgroundColor: whiteColor,
              textColor: blackColor,
            );
          } else {
            Fluttertoast.showToast(msg: error.toString());
          }
        }
      });
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print('I am from here');
      rethrow;
    }
  }

  Future<void> createPaymentIndent(
    double total,
    List<Cart> productsList,
  ) async {
    try {
      isLoading(true);
      Map<String, dynamic> body = {
        'amount': '${(total * 100).toInt()}',
        'currency': 'SEK',
        'receipt_email': userController.user.user_email.toString(),
        'description': json.encode({
          "Customer Name": userController.user.user_name.toString(),
          "User Id": userController.user.user_id,
          "Products": productsList,
        }),
      };

      http.Response response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51OCJahB1AQ87VcfcLwYmmSl1wQ3cuNyAR4RONZ4OLMluwTLLfMl5OuabL176cDdIv6tEr2VKjSxzMMynF6a3Sj2E00XKndgTi2",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      paymentIntent = json.decode(response.body);
    } catch (e) {
      isLoading(false);

      Fluttertoast.showToast(msg: e.toString());
      throw Exception(e.toString());
    }
  }
  //!Stripe payment processing ends here

  //! Update users data starts here
  Future<void> updateUserData() async {
    try {
      var res = await http.post(Uri.parse(Api.addUserInfo), body: {
        "user_id": userController.user.user_id.toString(),
        "full_name": fullNameController.text.toString(),
        "zip_code": zipCodeController.text.toString(),
        "address": addressController.text.toString(),
        "city_town": cityTownController.text.toString(),
        "contact_number": contactNumberController.text.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          //!Call the remove cart id in database
        } else {
          Fluttertoast.showToast(msg: serverError);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  //! Update users data end here

  //! Add to the orders table in the database starts here
  Future<void> addOrderInfo(
      {required List<Cart> selectedItems, required double totalAmount}) async {
    try {
      var res = await http.post(Uri.parse(Api.addOrderInfo), body: {
        "user_id": userController.user.user_id.toString(),
        "selected_item": jsonEncode(selectedItems),
        "total_price": totalAmount.toString(),
        "delivery_fee":
            selectedShippingMethod.value == 0 ? deliveryFee.toString() : "0",
        "shipping_method":
            shippingMethods[selectedShippingMethod.value].toString(),
        "amount_paid": totalAmount.toString(),
        "payment_method": "Stripe",
        "order_date": DateTime.now().toIso8601String(),
        "order_note": orderNoteController.text.trim(),
        "full_name": fullNameController.text.trim(),
        "address": addressController.text.trim(),
        "city_town": cityTownController.text.trim(),
        "zip_code": zipCodeController.text.toString().trim(),
        "contact_number": contactNumberController.text.toString().trim(),
        "status": "0"
      });
      print(res.body);
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          await removeSelectedItem(selectedItems);
          print("Order placed successfully");
        } else {
          print(resBody);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
  //! Add to the orders table in the database ends here

  //! removeSelectedItem and remove the cart id after order starts here
  var cartController = Get.find<CartController>();
  Future<void> removeSelectedItem(List<Cart> selectedItems) async {
    for (var singleCartItem in selectedItems) {
      await cartController.removeSingleCart(
          singleCartItem.cart_id, singleCartItem.user_id);
      cartController.removeAllSelectedItem();
    }
  }
  //! removeSelectedItem and remove the cart id after order ends here

  Future<UserInfo> fetchUserAddress() async {
    UserInfo userInfo = UserInfo('user_name', 'user_email', 'full_name', 12345,
        'address', 'city_town', 12345678);

    try {
      var res = await http.post(Uri.parse(Api.readUserInfo), body: {
        'user_id': userController.user.user_id.toString(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        userInfo = UserInfo.fromJson(resBody['cartList'][0]);
        return userInfo;
      }
    } catch (e) {
      print(e.toString());
    }
    return userInfo;
  }

  //! Coupon Discounts

  Future getCouponCodeDetails(code) async {
    hasCoupon(false);
    try {
      var res = await http.post(Uri.parse(Api.couponCodes), body: {
        'coupon_code': code.toString(),
      });

      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        if (resbody['success']) {
          if (resbody['couponDetails'] != null) {
            Coupon theCoupon = Coupon.fromJson(resbody['couponDetails']);
            coupondiscount = theCoupon;
            hasCoupon(true);
          } else {
            hasCoupon(false);
          }
        } else {
          hasCoupon(false);
          print('object');
        }
      }
    } catch (error) {
      hasCoupon(false);
      rethrow;
    }
  }
}
