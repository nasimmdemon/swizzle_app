import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

import '../../controllers/custom_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  var controller = Get.find<CurrentUser>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: profile.text.make(), centerTitle: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                icAppLogo,
                height: 100,
              ),
            ),
            appName.text.make(),
            30.heightBox,
            "Hello, ${controller.user.user_name}".text.size(22).make(),
            5.heightBox,
            controller.user.user_email.text.make(),
            10.heightBox,
            ElevatedButton(
              onPressed: () {
                //TODO: Logout the user
                CustomBottomSheet().openBottomSheet(
                  context,
                  areYouSureWantToLogout,
                  () {
                    UserPrefes.clearUserData();
                  },
                  yes,
                );
              },
              child: "Logout".text.make(),
            )
          ],
        ));
  }
}
