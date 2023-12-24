// ignore_for_file: must_be_immutable

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/favourite_controller.dart';
import 'package:swizzle/users/controllers/home_controller.dart';
import 'package:swizzle/users/model/items.dart';
import 'package:swizzle/users/screens/Cart/cart_screen.dart';
import 'package:swizzle/users/screens/Item/item_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  var controller = Get.find<HomeController>();

  HomeScreen({super.key});

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      controller.getFlashSaleProducts();
      controller.getLatstProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appName.text.make(),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showSearchBottomBar(context, controller);
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Get.to(() => const CartScreen());
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: () => _handleRefresh(),
          color: whiteColor,
          backgroundColor: blackColor,
          height: 80,
          animSpeedFactor: 2,
          springAnimationDurationInMilliseconds: 500,
          showChildOpacityTransition: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VxSwiper(
                    //   items: [
                    //     Image.network(
                    //         'https://img.freepik.com/fotos-premium/cigarrillo-electronico-desechable-amarillo-sobre-fondo-amarillo-brillante-vape-sabor-melon-pina-o-limon_126267-4202.jpg'),
                    //     Image.network(
                    //         'https://img.freepik.com/premium-photo/set-colorful-disposable-electronic-cigarettes-green-background-modern-smoking_106745-1395.jpg'),
                    //     Image.network(
                    //         'https://img.freepik.com/premium-photo/disposable-electronic-cigarettes-color-background_661495-9643.jpg'),
                    //   ],
                    //   autoPlay: true,
                    //   height: 200,
                    //   aspectRatio: 16 / 3,
                    //   autoPlayInterval: const Duration(seconds: 2),
                    //   enlargeCenterPage: true,
                    // ),

                    theMainSlider(),
                    flashSale.text.size(22).bold.make(),
                    flashSaleWid(context),
                    30.heightBox,
                    latestProducts.text.size(22).bold.make(),
                    latestProdWid(context),
                    30.heightBox,
                    controller.variableProduct.isNotEmpty
                        ? variableItems.text.size(22).bold.make()
                        : Container(),
                    controller.variableProduct.isNotEmpty
                        ? flashSaleWid(context, "variable")
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

showSearchBottomBar(context, homeController) {
  var controller = Get.put(HomeController());
  var searchController = TextEditingController();
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                top: 20,
                left: 20,
                right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4, width: 100)
                    .box
                    .color(fontGrey)
                    .makeCentered(),
                30.heightBox,
                TextFormField(
                  maxLines: 1,
                  controller: searchController,
                  validator: (value) {
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    homeController.fireSearch(searchController.text.trim());
                  },
                  textInputAction: TextInputAction.search,
                  autofocus: false,
                  decoration: const InputDecoration(
                      hintText: exploreProducts,
                      labelText: search,
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                20.heightBox,
                searchController.text.isNotEmpty
                    ? Container(
                        child: homeController.searcing.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: homeController.searchItems.length,
                                itemBuilder: (context, index) {
                                  Item eachSearchItem =
                                      homeController.searchItems[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          ItemDetailScreen(eachSearchItem));
                                    },
                                    child: Row(
                                      children: [
                                        Image.network(
                                          eachSearchItem.item_image,
                                          fit: BoxFit.cover,
                                        )
                                            .box
                                            .size(100, 100)
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .make(),
                                        Expanded(
                                            child: Text(
                                          eachSearchItem.item_name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        eachSearchItem.item_price.text.make(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(const EdgeInsets.all(8))
                                        .padding(const EdgeInsets.symmetric(
                                            horizontal: 12))
                                        .roundedSM
                                        .shadowSm
                                        .make(),
                                  );
                                }),
                      )
                    : Container()
              ],
            ),
          ),
        );
      });
}

Widget theMainSlider() {
  var controller = Get.put(HomeController());

  return Obx(
    () => controller.shimmer.value
        ? Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.6),
            child: VxSwiper.builder(
                aspectRatio: 16 / 9,
                height: 230,
                enlargeCenterPage: true,
                autoPlay: true,
                itemCount: controller.sliderItems.length,
                itemBuilder: (context, index) {
                  var eachImage = controller.sliderItems[index];
                  return FadeInImage(
                    placeholder: const AssetImage(icLoadingImage),
                    image: NetworkImage(
                      eachImage['image_link'],
                    ),
                    fit: BoxFit.cover,
                  )
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(const EdgeInsets.symmetric(horizontal: 8))
                      .make();
                }),
          )
        : VxSwiper.builder(
            aspectRatio: 16 / 9,
            height: 230,
            enlargeCenterPage: true,
            autoPlay: true,
            itemCount: controller.sliderItems.length,
            itemBuilder: (context, index) {
              var eachImage = controller.sliderItems[index];
              return Image.network(
                eachImage['image_link'],
                fit: BoxFit.cover,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 8))
                  .make();
            }),
  );
}

Widget flashSaleWid(BuildContext context, [itemType = 'simple']) {
  var controller = Get.put(HomeController());
  var favouriteController = Get.put(FavouriteController());

  return SizedBox(
    height: 250,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemType == 'simple'
            ? controller.flashSaleProducts.length
            : controller.variableProduct.length,
        itemBuilder: (context, index) {
          Item eachItemData = itemType == 'simple'
              ? controller.flashSaleProducts[index]
              : controller.variableProduct[index];
          var imageAnimation;
          return GestureDetector(
            onTap: () {
              favouriteController.validateFavourite(eachItemData.item_id);
              Get.to(() => ItemDetailScreen(eachItemData));
            },
            child: Obx(
              () => controller.shimmer.value
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.6),
                      child: Container(
                        width: 180,
                        margin: EdgeInsets.fromLTRB(
                            index == 0 ? 16 : 8,
                            10,
                            index == controller.flashSaleProducts.length - 1
                                ? 16
                                : 8,
                            10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whiteColor,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(2, 3),
                                blurRadius: 7,
                                color: fontGrey,
                              )
                            ]),
                        child: Column(
                          children: [
                            //! Item image parts starts here
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Hero(
                                tag: 'item${eachItemData.item_id}',
                                child: FadeInImage(
                                  placeholder: const AssetImage(icAppLogo),
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(eachItemData.item_image),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Center(
                                      child: "Server Error. Contact Server"
                                          .text
                                          .make(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //! Item image parts ends here

                            //! Item image parts ends here
                            Expanded(
                                child: Text(
                              eachItemData.item_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "kr${eachItemData.item_price}",
                                  style: const TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                " kr${eachItemData.item_sale_price}"
                                    .text
                                    .bold
                                    .make()
                              ],
                            ),
                            5.heightBox,
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: 180,
                      margin: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 8,
                          10,
                          index == controller.flashSaleProducts.length - 1
                              ? 16
                              : 8,
                          10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(2, 3),
                              blurRadius: 7,
                              color: fontGrey,
                            )
                          ]),
                      child: Column(
                        children: [
                          //! Item image parts starts here
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Hero(
                              tag: 'item${eachItemData.item_id}',
                              child: FadeInImage(
                                placeholder: const AssetImage(icAppLogo),
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                                image: NetworkImage(eachItemData.item_image),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Center(
                                    child: "Server Error. Contact Server"
                                        .text
                                        .make(),
                                  );
                                },
                              ),
                            ),
                          ),
                          //! Item image parts ends here

                          //! Item image parts ends here
                          Expanded(
                              child: Text(
                            eachItemData.item_name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "kr${eachItemData.item_price}",
                                style: const TextStyle(
                                  color: redColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              " kr${eachItemData.item_sale_price}"
                                  .text
                                  .bold
                                  .make()
                            ],
                          ),
                          5.heightBox,
                        ],
                      ),
                    ),
            ),
          );
        }),
  );
}

Widget latestProdWid(BuildContext context) {
  var controller = Get.put(HomeController());
  var favouriteController = Get.put(FavouriteController());
  return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: controller.latestProduct.length,
      itemBuilder: (context, index) {
        Item eachItemData = controller.latestProduct[index];
        return GestureDetector(
          onTap: () {
            favouriteController.validateFavourite(eachItemData.item_id);
            Get.to(() => ItemDetailScreen(eachItemData));
          },
          child: Obx(
            () => controller.shimmer.value
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.6),
                    child: eachItemData.item_type == 'simple'
                        ? Container(
                            width: 180,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(2, 3),
                                    blurRadius: 7,
                                    color: fontGrey,
                                  )
                                ]),
                            child: Column(
                              children: [
                                //! Item image parts starts here
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Hero(
                                    tag: 'item${eachItemData.item_id}',
                                    child: FadeInImage(
                                      placeholder: const AssetImage(icAppLogo),
                                      width: 180,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(eachItemData.item_image),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: "Server Error. Contact Server"
                                              .text
                                              .make(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                //! Item image parts ends here

                                //! Item image parts ends here
                                Expanded(
                                    child: Text(
                                  eachItemData.item_name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                " $currency${eachItemData.item_price}"
                                    .text
                                    .bold
                                    .make(),
                                5.heightBox,
                              ],
                            ),
                          )
                        : Container(
                            width: 180,
                            margin: EdgeInsets.fromLTRB(
                                index == 0 ? 16 : 8,
                                10,
                                index == controller.latestProduct.length - 1
                                    ? 16
                                    : 8,
                                10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(2, 3),
                                    blurRadius: 7,
                                    color: fontGrey,
                                  )
                                ]),
                            child: Column(
                              children: [
                                //! Item image parts starts here
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Hero(
                                    tag: 'item${eachItemData.item_id}',
                                    child: FadeInImage(
                                      placeholder: const AssetImage(icAppLogo),
                                      width: 180,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(eachItemData.item_image),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: "Server Error. Contact Server"
                                              .text
                                              .make(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                //! Item image parts ends here

                                //! Item image parts ends here
                                Expanded(
                                    child: Text(
                                  eachItemData.item_name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                " $currency${eachItemData.item_price}"
                                    .text
                                    .bold
                                    .make(),
                                5.heightBox,
                              ],
                            ),
                          ),
                  )
                : Container(
                    width: 180,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: whiteColor,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 3),
                            blurRadius: 7,
                            color: fontGrey,
                          )
                        ]),
                    child: Column(
                      children: [
                        //! Item image parts starts here
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Hero(
                            tag: 'item${eachItemData.item_id}',
                            child: FadeInImage(
                              placeholder: const AssetImage(icAppLogo),
                              width: 180,
                              height: 180,
                              fit: BoxFit.cover,
                              image: NetworkImage(eachItemData.item_image),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: "Server Error. Contact Server"
                                      .text
                                      .make(),
                                );
                              },
                            ),
                          ),
                        ),
                        //! Item image parts ends here

                        //! Item image parts ends here
                        Expanded(
                            child: Text(
                          eachItemData.item_name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        " $currency${eachItemData.item_price}".text.bold.make(),
                        5.heightBox,
                      ],
                    ),
                  ),
          ),
        );
      });
}
