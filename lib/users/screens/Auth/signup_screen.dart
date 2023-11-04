import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/auth_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_test_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var controller = Get.put(AuthController());
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ).box.color(whiteColor).shadowSm.roundedFull.make(),
                ),
                10.heightBox,
                signup.text.bold.size(38).make(),
                20.heightBox,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        customTextField(
                            controller: controller.nameController,
                            hint: namePlaceholder,
                            label: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return basicValidation;
                              } else {
                                return null;
                              }
                            }),
                        10.heightBox,
                        customTextField(
                            controller: controller.emailController,
                            hint: emailPlaceholder,
                            label: emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return basicValidation;
                              } else if (!value.contains("@")) {
                                return invalidEmail;
                              } else if (!value.contains(".")) {
                                return invalidEmail;
                              }
                              return null;
                            }),
                        10.heightBox,
                        customTextField(
                            controller: controller.passwordController,
                            hint: passwordPlaceholder,
                            label: password,
                            isPass: true,
                            validator: (value) {
                              if (value!.length < 8) {
                                return typeAtLeast;
                              }
                              return null;
                            }),
                        10.heightBox,
                        customTextField(
                          controller: controller.confirmPasswordController,
                          hint: passwordPlaceholder,
                          label: confirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return basicValidation;
                            } else {
                              return null;
                            }
                          },
                          isPass: true,
                        ),
                        20.heightBox,
                        customButton(
                            title: btnContinue,
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                if (controller.passwordController.text !=
                                    controller.confirmPasswordController.text) {
                                  controller.customBottomSheet(
                                      context, passwordDoesnotMatch);
                                } else {
                                  controller.validateEmail(context);
                                }
                              }
                            }),
                      ],
                    )),
                10.heightBox,
                Row(
                  children: [
                    alreadyHaveAnAccount.text.make(),
                    signin.text.bold.make().onTap(() {
                      Get.back();
                    })
                  ],
                ),
              ],
            )));
  }
}
