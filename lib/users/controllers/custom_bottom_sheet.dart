import 'package:swizzle/consts/consts.dart';

import '../../widgets/custom_button.dart';

class CustomBottomSheet extends GetxController {
  openBottomSheet(context, String content, onTap, String btnTitle,
      [bool isDismissable = true]) {
    showModalBottomSheet(
        isDismissible: isDismissable,
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
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: customButton(title: btnTitle, ontap: onTap),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       customButton(title: titleYes, ontap: onTapYes),
              //       5.widthBox,
              //       customButton(title: titleNo, ontap: onTapNo),
              //     ],
              //   ),
              // )
            ],
          );
        });
  }
}
