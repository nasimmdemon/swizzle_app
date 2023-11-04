import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/screens/Auth/login_screen.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

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
            "Hello, Peiman".text.size(22).make(),
            5.heightBox,
            'info@swizzle.se'.text.make(),
            10.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: blackColor),
              onPressed: () {
                //TODO: Logout the user
                Get.offAll(const LoginScreen());
              },
              child: "Logout".text.make(),
            )
          ],
        ));
  }
}
