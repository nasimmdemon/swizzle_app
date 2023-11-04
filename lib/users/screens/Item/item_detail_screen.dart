import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/cart_controller.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/controllers/favourite_controller.dart';
import 'package:swizzle/users/controllers/item_controller.dart';
import 'package:swizzle/users/model/items.dart';
import 'package:swizzle/widgets/custom_button.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item itemData;
  const ItemDetailScreen(this.itemData, {super.key});

  @override
  Widget build(BuildContext context) {
    var imageAnimation;
    var controller = Get.put(ItemController());
    var cartController = Get.put(CartController());
    var favController = Get.put(FavouriteController());
    int userId = Get.find<CurrentUser>().user.user_id;

    return Scaffold(
      appBar: AppBar(
        title: Text(itemData.item_name),
      ),
      body: Stack(
        children: [
          Container(
            child: Hero(
                key: imageAnimation,
                tag: 'item${itemData.item_id}',
                child: Image.network(itemData.item_image)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: context.screenHeight * 0.5,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: fontGrey,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightBox,
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 3,
                          width: 80,
                          color: fontGrey,
                        ),
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: itemData.item_name.text.size(23).make()),
                          Obx(
                            () => IconButton(
                                onPressed: () {
                                  if (favController.isFavourite) {
                                    favController
                                        .removeFromFavourite(itemData.item_id);
                                  } else {
                                    favController
                                        .addToFavourite(itemData.item_id);
                                  }
                                },
                                icon: Icon(favController.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border)),
                          )
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (controller.quantity.value > 1) {
                                      controller.quantity.value =
                                          controller.quantity.value - 1;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: redColor,
                                  )),
                              Obx(
                                () => Text(controller.quantity.toString())
                                    .box
                                    .shadow
                                    .white
                                    .padding(const EdgeInsets.all(10))
                                    .roundedSM
                                    .make(),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.quantity.value =
                                        controller.quantity.value + 1;
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  )),
                            ],
                          ),
                          Obx(
                            () => itemData.item_sale_price == 0
                                ? "$currency ${itemData.item_price * controller.quantity.value}"
                                    .text
                                    .size(19)
                                    .bold
                                    .make()
                                : Row(
                                    children: [
                                      Text(
                                        "kr${itemData.item_price}",
                                        style: const TextStyle(
                                          color: redColor,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      " kr${itemData.item_sale_price * controller.quantity.value}"
                                          .text
                                          .bold
                                          .make()
                                    ],
                                  ),
                          )
                        ],
                      ),
                      10.heightBox,
                      description.text.size(18).bold.make(),
                      10.heightBox,
                      itemData.item_description.text.make(),
                      10.heightBox,
                      customButton(
                          ontap: () {
                            // controller.addToCart(
                            //     itemData.item_id, itemData.item_price);

                            controller.chechIfItemInCart(
                                userId, itemData.item_id);
                          },
                          title: addToCart)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
