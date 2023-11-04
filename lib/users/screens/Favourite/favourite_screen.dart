import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/favourite_controller.dart';
import 'package:swizzle/users/model/items.dart';
import 'package:swizzle/users/screens/Item/item_detail_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FavouriteController());

    return Scaffold(
      appBar: AppBar(title: favourite.text.make(), centerTitle: true),
      body: Obx(() => controller.userFavlist.isEmpty
          ? noItemInFavAddSome.text.size(18).makeCentered()
          : ListView.builder(
              itemCount: controller.userFavlist.length,
              itemBuilder: (contect, index) {
                Item eachCartItem = controller.userFavlist[index];
                return GestureDetector(
                  onTap: () {
                    controller.validateFavourite(eachCartItem.item_id);
                    Get.to(ItemDetailScreen(eachCartItem));
                  },
                  child: Slidable(
                    endActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (_) {
                          controller.removeFromFavourite(eachCartItem.item_id);
                        },
                        backgroundColor: redColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: delete,
                      ),
                    ]),
                    child: Container(
                      margin:
                          EdgeInsets.fromLTRB(10, index == 0 ? 7 : 10, 10, 5),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Hero(
                            tag: "item${eachCartItem.item_id}",
                            child: Image.network(
                              eachCartItem.item_image,
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
                              eachCartItem.item_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          5.widthBox,
                          eachCartItem.item_sale_price > 0
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 8),
                                  color: blackColor,
                                  child: onSale.text.white.make(),
                                )
                              : Container(),
                          10.widthBox,
                          eachCartItem.item_sale_price == 0
                              ? eachCartItem.item_price.text.make()
                              : eachCartItem.item_sale_price.text.make(),
                          IconButton(
                            onPressed: () {
                              controller
                                  .removeFromFavourite(eachCartItem.item_id);
                            },
                            icon: const Icon(Icons.remove),
                          )
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
                  ),
                );
              })),
    );
  }
}
