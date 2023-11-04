import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/home_controller.dart';
import 'package:swizzle/users/screens/Auth/login_screen.dart';
import 'package:swizzle/users/screens/dashboard_screen.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

import '../../../widgets/app_logo_widget.dart';

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
  changeScreen(userInfo) {
    Future.delayed(const Duration(seconds: 3), () {
      if (userInfo != null) {
        Get.offAll(() => DashboardScreen());
      } else {
        Get.offAll(const LoginScreen());
      }
    });
  }

  @override
  void initState() {
    var homeController = Get.put(HomeController());

    homeController.sliderImageFetch();
    homeController.getFlashSaleProducts();
    homeController.getLatstProducts();
    homeController.changeShimmerStatus();
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
