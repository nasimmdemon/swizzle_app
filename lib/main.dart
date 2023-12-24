import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:swizzle/users/screens/Splash/splash_screen.dart';

import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51OCJahB1AQ87VcfcUUUfCJB38bcrJLBoUyT77stOfoOWOXakJh5BAo76sHbs9PSz3SqXV6vTHBqx0W6eX1MDscdz00MvuJibam";
  Stripe.merchantIdentifier = 'any string works';

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
              backgroundColor: whiteColor,
              foregroundColor: blackColor,
              elevation: 0),
          fontFamily: 'mainFont',
        ),
        home: const SplashScreen());
  }
}
