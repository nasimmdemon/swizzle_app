import 'package:swizzle/consts/consts.dart';

Widget customTextField({
  String? hint = "hint goes here",
  String? label = "Label goes here",
  bool isPass = false,
  String? initialValue,
  int maxLines = 1,
  TextInputType inputType = TextInputType.text,
  TextInputAction inputAction = TextInputAction.done,
  String? Function(String?)? validator,
  TextEditingController? controller,
}) {
  return TextFormField(
    maxLines: maxLines,
    controller: controller,
    validator: validator,
    obscureText: isPass ? true : false,
    textInputAction: inputAction,
    keyboardType: inputType,
    autofocus: false,
    initialValue: initialValue,
    decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8)))),
  );
}
