import 'package:swizzle/admin/dashboard/admin_dashboard_screen.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/auth_controller.dart';
import 'package:swizzle/users/screens/Auth/signup_screen.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_test_field.dart';
import '../../../widgets/social_signin_wid.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    20.heightBox,
                    signin.text.bold.size(38).make(),
                    20.heightBox,
                    customTextField(
                        controller: controller.emailController,
                        hint: emailPlaceholder,
                        label: emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return basicValidation;
                          } else if (!value.contains("@")) {
                            return invalidEmail;
                          } else {
                            return null;
                          }
                        }),
                    10.heightBox,
                    customTextField(
                        controller: controller.passwordController,
                        hint: passwordPlaceholder,
                        label: password,
                        isPass: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return basicValidation;
                          } else if (value.length < 8) {
                            return typeAtLeast;
                          }
                          return null;
                        }),
                    20.heightBox,
                    customButton(
                      title: btnContinue,
                      ontap: () {
                        //Home Screen
                        if (formKey.currentState!.validate()) {
                          if (controller.emailController.text == adminEmail &&
                              controller.passwordController.text ==
                                  adminPassword) {
                            Get.off(AdminDashboardScreen());
                          } else {
                            controller.loginUser(context);
                          }
                        }
                      },
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        donthaveanaccount.text.make(),
                        createOne.text.bold.make().onTap(() {
                          Get.to(() => const SignupScreen());
                        })
                      ],
                    ),
                    30.heightBox,
                    socialSigninWid(icon: icApple, title: continuewithapple),
                    10.heightBox,
                    socialSigninWid(icon: icGoogle, title: continueWithGoogle),
                    10.heightBox,
                    socialSigninWid(
                        icon: icFacebook, title: continuewithFacebook),
                  ],
                ))));
  }
}
