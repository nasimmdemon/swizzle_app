import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/cart_controller.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/controllers/custom_bottom_sheet.dart';
import 'package:swizzle/users/screens/Shipping/shipping_screen.dart';

import '../../../widgets/custom_button.dart';
import '../../model/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var currentUser = Get.find<CurrentUser>();

  var controller = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    controller.fetchUserCartList(currentUser.user.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "${currentUser.user.user_name}'s Cart".text.make(),
        actions: [
          Obx(
            () => controller.grandTotal > 0
                ? IconButton(
                    onPressed: () {
                      CustomBottomSheet().openBottomSheet(
                          context, areYouSureWantToRemoveTheSelectedItems, () {
                        controller.removeFromCart(currentUser.user.user_id);
                        Get.back();
                      }, yes);
                    },
                    icon: const Icon(Icons.delete))
                : Container(),
          ),
          Obx(
            () => controller.cartList.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controller.isSelectedAll
                          ? controller.removeAllSelectedItem()
                          : controller.selectAll();
                    },
                    icon: Obx(
                      () => Icon(controller.isSelectedAll
                          ? Icons.check_box
                          : Icons.check_box_outline_blank),
                    ))
                : Container(),
          )
        ],
      ),
      body: Column(
        children: [
          10.heightBox,
          AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [ScaleAnimatedText(slideLeftToRemove)]),
          SizedBox(
              height: context.screenHeight * 0.6,
              child: Obx(
                () => controller.cartList.isNotEmpty
                    ? userCartList()
                    : Center(
                        child: cartisEmptyAddSome.text.make(),
                      ),
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => customButton(
                  ontap: controller.cartList.isNotEmpty &&
                          controller.selectedItem.isNotEmpty
                      ? () {
                          Get.to(() {
                            List<Cart> selectedItemForOrder = [];
                            for (var singleCartItem in controller.cartList) {
                              if (controller.selectedItem
                                  .contains(singleCartItem.item_id)) {
                                selectedItemForOrder.add(singleCartItem);
                              }
                            }
                            return ShippingScreen(
                              total: controller.grandTotal,
                              cartInforMation: selectedItemForOrder,
                            );
                          });
                        }
                      : null,
                  title: "Continue ${controller.grandTotal}$currency"),
            ),
          ),
          10.heightBox,
        ],
      ),
    );
  }

  Widget userCartList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: controller.cartList.length,
        itemBuilder: (context, index) {
          Cart cartItem = controller.cartList[index];

          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: cartItem == 0 ? 0 : 10),
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (_) {
                      CustomBottomSheet().openBottomSheet(
                          context,
                          cartItem.item_qty > 1
                              ? thisWillRemoveSingleQuantity
                              : areYouSureWantToRemoveTheItem, () {
                        if (controller.selectedItem
                            .contains(cartItem.item_id)) {
                          controller.removeSelectedItem(cartItem.item_id);
                          if (cartItem.item_qty > 1) {
                            controller.reduceCartQuantity(
                                cartItem.cart_id, currentUser.user.user_id);
                          } else {
                            controller.removeSingleCart(
                                cartItem.cart_id, currentUser.user.user_id);
                          }
                        } else {
                          if (cartItem.item_qty > 1) {
                            controller.reduceCartQuantity(
                                cartItem.cart_id, currentUser.user.user_id);
                          } else {
                            controller.removeSingleCart(
                                cartItem.cart_id, currentUser.user.user_id);
                          }
                        }
                        Get.back();
                      }, yes);
                    },
                    backgroundColor: redColor,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: delete,
                  ),
                ]),
                child: GetBuilder(
                  init: CartController(),
                  builder: (_) => Stack(
                    alignment: AlignmentDirectional.topEnd,
                    fit: StackFit.loose,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(10, index == 0 ? 7 : 10, 10, 5),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (controller.selectedItem
                                      .contains(cartItem.item_id)) {
                                    controller
                                        .removeSelectedItem(cartItem.item_id);
                                  } else {
                                    controller
                                        .addSelectedItem(cartItem.item_id);
                                  }
                                },
                                icon: Icon(controller.selectedItem
                                        .contains(cartItem.item_id)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank)),
                            Hero(
                              tag: "item${cartItem.item_id}",
                              child: Image.network(
                                cartItem.item_image,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedLg
                                  .size(100, 100)
                                  .clip(Clip.antiAlias)
                                  .make(),
                            ),
                            10.widthBox,
                            Expanded(
                              child: Text(
                                cartItem.item_name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            5.widthBox,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "${cartItem.sale_price == 0 ? (cartItem.item_price * cartItem.item_qty) : (cartItem.sale_price * cartItem.item_qty)}$currency"
                                    .text
                                    .bold
                                    .make(),
                                Text("${cartItem.item_qty.toString()}$mesasure")
                              ],
                            ),
                          ],
                        ),
                      )
                          .box
                          .shadowSm
                          .margin(const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5))
                          .color(Colors.white.withOpacity(0.9))
                          .roundedLg
                          .make(),
                      cartItem.sale_price > 0
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              color: redColor,
                              child: onSale.text.white.make(),
                            ).box.rounded.clip(Clip.antiAlias).make()
                          : Container(),
                    ],
                  ),
                ),
              ),
              // Image.network(
              //   cartItem.item_image,
              //   height: 80,
              //   width: 80,
              //   fit: BoxFit.cover,
              // ),
              // Expanded(
              //   child: Text(
              //     cartItem.item_name,
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              // Text("${cartItem.item_qty.toString()}$mesasure"),
              // 10.widthBox,
              // "${cartItem.sale_price == 0 ? (cartItem.item_price * cartItem.item_qty) : (cartItem.sale_price * cartItem.item_qty)}$currency"
              //     .text
              //     .bold
              //     .make(),
              // 10.heightBox,
              // IconButton(
              //     color: redColor,
              //     onPressed: () {
              // CustomBottomSheet().openBottomSheet(
              //     context, areYouSureWantToRemoveTheItem, () {
              //   if (controller.selectedItem
              //       .contains(cartItem.item_id)) {
              //     controller.removeSelectedItem(cartItem.item_id);
              //     if (cartItem.item_qty > 1) {
              //       controller.reduceCartQuantity(
              //           cartItem.cart_id, currentUser.user.user_id);
              //     } else {
              //       controller.removeSingleCart(
              //           cartItem.cart_id, currentUser.user.user_id);
              //     }
              //   } else {
              //     if (cartItem.item_qty > 1) {
              //       controller.reduceCartQuantity(
              //           cartItem.cart_id, currentUser.user.user_id);
              //     } else {
              //       controller.removeSingleCart(
              //           cartItem.cart_id, currentUser.user.user_id);
              //     }
              //   }
              //   Get.back();
              // }, yes);
              //     },
              //     icon: const Icon(Icons.remove))
            ),
          );
        });
  }
}
