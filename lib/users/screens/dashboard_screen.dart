import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/controllers/home_controller.dart';
import 'package:swizzle/users/screens/Favourite/favourite_screen.dart';
import 'package:swizzle/users/screens/Home/home_screen.dart';
import 'package:swizzle/users/screens/Order/order_screen.dart';
import 'package:swizzle/users/screens/Profile/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final CurrentUser _currentUser = Get.put(CurrentUser());
  var homeController = Get.put(HomeController());
  List<Widget> screens = [
    HomeScreen(),
    const FavouriteScreen(),
    const OrderScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _currentUser.getUserInfo();
      },
      builder: (controller) {
        return Obx(
          () => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                iconSize: 27,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                currentIndex: homeController.screenIndex.value,
                onTap: (index) {
                  homeController.screenIndex.value = index;
                },
                unselectedItemColor: blackColor,
                selectedItemColor: Colors.red,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                      backgroundColor: whiteColor),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favourite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag_rounded),
                      label: "My Orders"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ]),
            body: screens[homeController.screenIndex.value],
          ),
        );
      },
    );
  }
}
