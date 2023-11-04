import 'package:swizzle/admin/add_product/admin_add_product_screen.dart';
import 'package:swizzle/admin/controllers/admin_home_controllers.dart';
import 'package:swizzle/admin/home/admin_home_screen.dart';
import 'package:swizzle/admin/order/admin_order_screen.dart';
import 'package:swizzle/admin/profile/admin_profile_screen.dart';
import 'package:swizzle/consts/consts.dart';

class AdminDashboardScreen extends StatelessWidget {
  var controller = Get.put(AdminHomeController());
  List<Widget> screens = [
    const AdminHomeScreen(),
    AdminAddProductScreen(),
    const AdminOrderScreen(),
    const AdminProfileScreen(),
  ];
  AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 27,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: controller.homeIndex.value,
            onTap: (index) {
              controller.homeIndex.value = index;
            },
            unselectedItemColor: blackColor,
            selectedItemColor: Colors.red,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: whiteColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_sharp), label: "Favourite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.euro), label: "My Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
        body: screens[controller.homeIndex.value],
      ),
    );
  }
}
