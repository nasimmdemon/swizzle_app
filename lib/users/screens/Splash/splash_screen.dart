import 'dart:io';

import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/app_status.dart';
import 'package:swizzle/users/controllers/update_dialogue_android.dart';
import 'package:swizzle/users/controllers/update_dialogue_ios.dart';
import 'package:swizzle/users/controllers/home_controller.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

import '../../../widgets/app_logo_widget.dart';
import '../Auth/login_screen.dart';
import '../dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Reading if the user already logged in
  readInfoFromLocalStorage() async {
    var userData = await UserPrefes.readUserPrefes();
    changeScreen(userData);
  }

  //Creating a methood to change sceren
  changeScreen(userInfo) async {
    var appDetailController = Get.put(AppStatus());
    // var itemController = Get.put(ItemController());
    // itemController.fetchVariableItem();
    var appDetail = await appDetailController.checkAppStatus();

    if (appDetail == 1) {
      Future.delayed(const Duration(seconds: 4), () {
        if (userInfo != null) {
          Get.offAll(() => DashboardScreen());
        } else {
          Get.offAll(const LoginScreen());
        }
      });
    } else if (appDetail == 0) {
      if (Platform.isIOS) {
        UpdateDialogueIos().showDialogue(
          context: context,
          title: updateAvailible,
          content: updateAvailiblePleaseUpdateTheApp,
          agreeBtnTitle: close,
        );
      } else {
        UpdateDialogueAndroid().showDialogue(
          context: context,
          title: updateAvailible,
          content: updateAvailiblePleaseUpdateTheApp,
          agreeBtnTitle: close,
        );
      }
    }
  }

  @override
  void initState() {
    var homeController = Get.put(HomeController());

    homeController.sliderImageFetch();
    homeController.getFlashSaleProducts();
    homeController.getLatstProducts();
    homeController.changeShimmerStatus();
    homeController.fetchVariableItem();
    readInfoFromLocalStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 99, 231),
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.4).heightBox,
            appLogoWidget().box.make(),
            10.heightBox,
            appName.text.size(22).white.make(),
            5.heightBox,
            appVersion.text.white.make(),
            const Spacer(),
            credits.text.fontFamily('blantick').size(26).white.make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
