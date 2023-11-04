import 'package:swizzle/consts/consts.dart';

Widget customButton({String? title = "Button Title", VoidCallback? ontap}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 5,
        shadowColor: Colors.grey,
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )),
    onPressed: ontap,
    child: title!.text.size(18).make(),
  );
}
