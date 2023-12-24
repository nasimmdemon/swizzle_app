import 'package:lottie/lottie.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/shipping_controller.dart';
import 'package:swizzle/users/model/cart.dart';
import 'package:swizzle/users/model/userInfo.dart';
import 'package:swizzle/widgets/custom_button.dart';
import 'package:swizzle/widgets/custom_test_field.dart';

class ShippingScreen extends StatelessWidget {
  final List<Cart> cartInforMation;
  final double total;
  const ShippingScreen(
      {super.key, required this.total, required this.cartInforMation});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ShippingController());
    var formKey = GlobalKey<FormState>();

    return Obx(
      () => Scaffold(
        appBar: controller.isLoading.value
            ? null
            : AppBar(
                title: deleveryInformation.text.make(),
                centerTitle: true,
              ),
        body: controller.isLoading.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Lottie.asset(
                      'assets/animations/payment_loading.json',
                      fit: BoxFit.cover,
                    ).box.height(200).makeCentered(),
                    pleaseWait.text.make(),
                  ])
            : Padding(
                padding: const EdgeInsets.all(13.0),
                child: FutureBuilder(
                    future: controller.fetchUserAddress(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        UserInfo currentUserInfo = snapshot.data!;
                        controller.setControllers(currentUserInfo);

                        return Form(
                          key: formKey,
                          child: ListView(
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: customTextField(
                                        controller:
                                            controller.fullNameController,
                                        label: fullName,
                                        hint: enterYourFullName,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return basicValidation;
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: customTextField(
                                        controller:
                                            controller.zipCodeController,
                                        label: zipCode,
                                        hint: enterYourZipCode,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return basicValidation;
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ),
                                ],
                              ),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: customTextField(
                                        controller:
                                            controller.cityTownController,
                                        label: cityTown,
                                        hint: enterCityTown,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return basicValidation;
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: customTextField(
                                        controller:
                                            controller.contactNumberController,
                                        label: contactNumber,
                                        hint: enterYourContactNumber,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return basicValidation;
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ),
                                ],
                              ),
                              10.heightBox,
                              customTextField(
                                  controller: controller.addressController,
                                  label: address,
                                  hint: enterYourAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return basicValidation;
                                    } else {
                                      return null;
                                    }
                                  }),
                              10.heightBox,
                              TextFormField(
                                maxLines: 1,
                                controller: controller.couponCodeController,
                                textInputAction: TextInputAction.done,
                                autofocus: false,
                                onChanged: (value) {
                                  // (DateFormat()
                                  //     .add_yMd()
                                  //     .format(DateTime.now()));
                                  controller.getCouponCodeDetails(value);
                                },
                                decoration: const InputDecoration(
                                    hintText: couponCode,
                                    labelText: "$couponCode ($ifHave)",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                              10.heightBox,
                              customTextField(
                                controller: controller.orderNoteController,
                                label: orderNote,
                                maxLines: 3,
                                hint: orderNotePlaceholder,
                              ),
                              20.heightBox,
                              selectShippingMethod.text.make(),
                              10.heightBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(shippingMethods.length,
                                    (index) {
                                  return Obx(
                                    () => Container(
                                      padding: const EdgeInsets.all(30),
                                      margin: const EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: controller
                                                          .selectedShippingMethod
                                                          .value ==
                                                      index
                                                  ? fontGrey
                                                  : Colors.transparent,
                                              offset: const Offset(1, 3),
                                              blurRadius: 10,
                                            )
                                          ]),
                                      child: shippingMethods[index].text.make(),
                                    ).onTap(() {
                                      controller.selectedShippingMethod.value =
                                          index;
                                    }),
                                  );
                                }),
                              ),
                              20.heightBox,
                              Obx(
                                () => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        itemsTotal.text.size(18).make(),
                                        "$currency $total".text.size(18).make()
                                      ],
                                    ),
                                    10.heightBox,
                                    controller.selectedShippingMethod.value == 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              deliveryFees.text.size(18).make(),
                                              "$currency $deliveryFee"
                                                  .text
                                                  .size(18)
                                                  .make()
                                            ],
                                          )
                                        : Container(),
                                    10.heightBox,
                                    controller.hasCoupon.value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              couponDiscount.text
                                                  .size(18)
                                                  .make(),
                                              "-${controller.coupondiscount.type == 'flat' ? '${controller.coupondiscount.amount}' : '${controller.coupondiscount.amount}%'}"
                                                  .text
                                                  .size(18)
                                                  .make()
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 5,
                                color: blackColor,
                              ),
                              Obx(
                                () =>
                                    "$currency ${controller.selectedShippingMethod.value == 0 && controller.hasCoupon.value == true && controller.coupondiscount.type == 'flat' ? total + deliveryFee - controller.coupondiscount.amount : controller.selectedShippingMethod.value == 1 && controller.hasCoupon.value && controller.coupondiscount.type == 'flat' ? total - controller.coupondiscount.amount : controller.selectedShippingMethod.value == 0 && controller.hasCoupon.value == true && controller.coupondiscount.type == 'percentage' ? (total + deliveryFee) - total * (controller.coupondiscount.amount / 100) : controller.selectedShippingMethod.value == 1 && controller.hasCoupon.value == true && controller.coupondiscount.type == 'percentage' ? (total) - total * (controller.coupondiscount.amount / 100) : total}"
                                        .text
                                        .size(26)
                                        .align(TextAlign.end)
                                        .bold
                                        .make(),
                              ),
                              40.heightBox,
                              customButton(
                                  title: "Place Order",
                                  ontap: () {
                                    controller.makePayment(
                                        controller.selectedShippingMethod.value == 0 &&
                                                controller.hasCoupon.value ==
                                                    true &&
                                                controller.coupondiscount.type ==
                                                    'flat'
                                            ? total +
                                                deliveryFee -
                                                controller.coupondiscount.amount
                                            : controller.selectedShippingMethod
                                                            .value ==
                                                        1 &&
                                                    controller
                                                        .hasCoupon.value &&
                                                    controller.coupondiscount.type ==
                                                        'flat'
                                                ? total -
                                                    controller
                                                        .coupondiscount.amount
                                                : controller
                                                                .selectedShippingMethod
                                                                .value ==
                                                            0 &&
                                                        controller.hasCoupon.value ==
                                                            true &&
                                                        controller.coupondiscount
                                                                .type ==
                                                            'percentage'
                                                    ? (total + deliveryFee) -
                                                        total *
                                                            (controller
                                                                    .coupondiscount
                                                                    .amount /
                                                                100)
                                                    : controller.selectedShippingMethod
                                                                    .value ==
                                                                1 &&
                                                            controller.hasCoupon
                                                                    .value ==
                                                                true &&
                                                            controller
                                                                    .coupondiscount
                                                                    .type ==
                                                                'percentage'
                                                        ? (total) -
                                                            total *
                                                                (controller
                                                                        .coupondiscount
                                                                        .amount /
                                                                    100)
                                                        : total,
                                        cartInforMation);
                                  })
                            ],
                          ),
                        );
                      } else {
                        return serverError.text.makeCentered();
                      }
                    })),
      ),
    );
  }
}
