import 'package:fluttertoast/fluttertoast.dart';
import 'package:swizzle/consts/consts.dart';

Widget socialSigninWid({
  String? icon = icAppLogo,
  String? title = "Title goes here",
  double? size = 16,
}) {
  return ElevatedButton.icon(
    onPressed: () {
      Fluttertoast.showToast(msg: socialSignInWillAvailibleSoon);
    },
    icon: Image.asset(icon!),
    label: title!.text.size(size).make(),
    style: ElevatedButton.styleFrom(
        foregroundColor: blackColor,
        backgroundColor: whiteColor,
        elevation: 5,
        shadowColor: whiteColor,
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )),
  );
}
