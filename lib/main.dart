import 'package:swizzle/users/screens/Home/home_screen.dart';
import 'package:swizzle/users/screens/Splash/splash_screen.dart';

import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: whiteColor, foregroundColor: blackColor),
          fontFamily: 'mainFont',
        ),
        home: const SplashScreen());
  }
}
