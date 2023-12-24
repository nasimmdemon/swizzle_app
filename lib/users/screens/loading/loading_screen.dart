import 'package:lottie/lottie.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/screens/dashboard_screen.dart';
import 'package:swizzle/users/user_prefes/user_info_on_local_storage.dart';

import '../../controllers/home_controller.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

void backToHome() async {
  await UserPrefes.readUserPrefes();
  Future.delayed(const Duration(seconds: 3), () {
    var homeController = Get.put(HomeController());

    homeController.sliderImageFetch();
    homeController.getFlashSaleProducts();
    homeController.getLatstProducts();
    homeController.shimmer.value = true;
    homeController.changeShimmerStatus();
    Get.to(() => DashboardScreen());
  });
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    backToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/done.json', repeat: false),
            10.heightBox,
            orderReceived.text.size(23).makeCentered()
          ],
        ),
      ),
    );
  }
}
