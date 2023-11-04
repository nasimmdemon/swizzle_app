import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/cart_controller.dart';
import 'package:swizzle/users/controllers/current_user.dart';

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
                      controller.removeFromCart(currentUser.user.user_id);
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
                  ontap: () {},
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
              child: Row(
                children: [
                  GetBuilder(
                    init: CartController(),
                    builder: (c) => IconButton(
                        onPressed: () {
                          if (controller.selectedItem
                              .contains(cartItem.item_id)) {
                            controller.removeSelectedItem(cartItem.item_id);
                          } else {
                            controller.addSelectedItem(cartItem.item_id);
                          }
                        },
                        icon: Icon(
                            controller.selectedItem.contains(cartItem.item_id)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank)),
                  ),
                  Image.network(
                    cartItem.item_image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Text(
                      cartItem.item_name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("${cartItem.item_qty.toString()}$mesasure"),
                  10.widthBox,
                  "${cartItem.sale_price == 0 ? (cartItem.item_price * cartItem.item_qty) : (cartItem.sale_price * cartItem.item_qty)}$currency"
                      .text
                      .bold
                      .make(),
                  10.heightBox,
                  IconButton(
                      color: redColor,
                      onPressed: () {
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
                      },
                      icon: const Icon(Icons.remove))
                ],
              ),
            ),
          );
        });
  }
}
