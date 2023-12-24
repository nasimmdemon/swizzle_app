import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/current_user.dart';
import 'package:swizzle/users/controllers/custom_bottom_sheet.dart';
import 'package:swizzle/users/controllers/order_controller.dart';
import 'package:swizzle/users/model/cart.dart';
import 'package:swizzle/users/model/order.dart';
import 'package:swizzle/users/model/user.dart';
import 'package:intl/intl.dart';
import 'package:swizzle/widgets/custom_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order orderData;

  const OrderDetailScreen({required this.orderData, super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.purple
    ];
    List<dynamic> orderItems = orderData.selectedItems;
    User currentOnlineUser = Get.find<CurrentUser>().user;
    var controller = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(title: orderDetail.text.make()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              "$hey, ${currentOnlineUser.user_name} !"
                  .text
                  .size(22)
                  .bold
                  .make(),
              thanksforYourOrder.text.make(),
              20.heightBox,
              '$yourItems :'.text.size(22).make(),
              10.heightBox,
              VxSwiper.builder(
                  enableInfiniteScroll: orderItems.length == 1 ? false : true,
                  autoPlay: orderItems.length == 1 ? false : true,
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: true,
                  aspectRatio: 2.8,
                  itemCount: orderItems.length,
                  itemBuilder: (context, index) {
                    var singleItemDetail = Cart.fromJson(orderItems[index]);
                    return Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              height: 100,
                              width: 100,
                              child: Image.network(
                                singleItemDetail.item_image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    singleItemDetail.item_name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  "$qty : ${singleItemDetail.item_qty}"
                                      .text
                                      .make(),
                                  const Divider(
                                    height: 4,
                                    color: fontGrey,
                                  ),
                                  "$price : $currency${singleItemDetail.item_price}"
                                      .text
                                      .make(),
                                ],
                              ),
                            )
                            // orderItems[index]['da']
                          ],
                        )
                            .box
                            .shadow
                            .white
                            .shadow
                            .margin(const EdgeInsets.all(7))
                            .rounded
                            .make(),
                        "${index + 1}"
                            .text
                            .make()
                            .box
                            .padding(const EdgeInsets.all(10))
                            .white
                            .shadow
                            .roundedFull
                            .make(),
                      ],
                    );
                  }),
              20.heightBox,
              '$orderDetails :'.text.size(22).make(),
              Column(
                children: [
                  10.heightBox,
                  orderData.status >= 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              orderData.status == 2
                                  ? Icons.done
                                  : Icons.circle_outlined,
                              color: orderData.status >= 0
                                  ? Colors.green
                                  : fontGrey,
                            ),
                            pending.text.make(),
                            Icon(
                              orderData.status == 2
                                  ? Icons.done
                                  : Icons.circle_outlined,
                              color: orderData.status >= 1
                                  ? Colors.green
                                  : fontGrey,
                            ),
                            processing.text.make(),
                            const Divider(thickness: 1),
                            Icon(
                              orderData.status == 2
                                  ? Icons.done
                                  : Icons.circle_outlined,
                              color: orderData.status < 2
                                  ? fontGrey
                                  : Colors.green,
                            ),
                            delivered.text.make(),
                          ],
                        )
                      : const SizedBox.shrink(),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$orderId :'.text.size(16).make(),
                      '#${orderData.orderId}'.text.size(16).make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$orderDate :'.text.size(16).make(),
                      DateFormat()
                          .add_yMMMMd()
                          .format(orderData.orderDate)
                          .text
                          .size(16)
                          .make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$shippingMethod :'.text.size(16).make(),
                      orderData.shippingMethod.text.size(16).make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$itemsTotal :'.text.size(16).make(),
                      '${orderData.totalPrice - orderData.deliveryFee}'
                          .text
                          .size(16)
                          .make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$shippingFee :'.text.size(16).make(),
                      '${orderData.deliveryFee}'.text.size(16).make(),
                    ],
                  ),
                  10.heightBox,
                  const Divider(
                    height: 6,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '$grandTotal :'.text.size(23).bold.make(),
                      '${orderData.amountPaid}'.text.size(23).bold.make(),
                    ],
                  ),
                  20.heightBox,
                ],
              )
                  .box
                  .white
                  .shadow
                  .rounded
                  .padding(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10))
                  .make(),
              20.heightBox,
              orderData.status >= 0
                  ? customButton(
                      title: cancelOrder,
                      ontap: orderData.status == 0
                          ? () {
                              CustomBottomSheet().openBottomSheet(
                                  context, areYouSureWantToCancelTheOrder, () {
                                Get.back();
                                controller.cancelOrder(orderData.orderId);
                              }, yes);
                            }
                          : () {
                              CustomBottomSheet().openBottomSheet(
                                  context, weCantCancelTheOrder, () {
                                Get.back();
                              }, close);
                            })
                  : theOrderIsCanceled.text.size(18).makeCentered()
            ],
          ),
        ),
      ),
    );
  }
}
