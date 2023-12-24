import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:swizzle/consts/consts.dart';
import 'package:swizzle/users/controllers/order_controller.dart';
import 'package:swizzle/users/model/order.dart';
import 'package:swizzle/users/screens/Order/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    Future<void> handleRefresh() async {
      return await Future.delayed(const Duration(seconds: 2), () {
        setState(() {});
      });
    }

    @override
    void initState() {
      handleRefresh();
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(title: myOrders.text.make(), centerTitle: true),
      body: FutureBuilder(
          future: controller.getUserOrderDetails(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return LiquidPullToRefresh(
                  onRefresh: () => handleRefresh(),
                  color: whiteColor,
                  backgroundColor: blackColor,
                  height: 80,
                  animSpeedFactor: 2,
                  springAnimationDurationInMilliseconds: 500,
                  showChildOpacityTransition: false,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        10.heightBox,
                        pullDownToRefresh.text.makeCentered(),
                        ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Order singleOrder = snapshot.data[index];

                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    10, index == 0 ? 7 : 10, 10, 5),
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        '$orderId: #${singleOrder.orderId}'
                                            .text
                                            .size(16)
                                            .make(),
                                        "$totalProducts: ${singleOrder.selectedItems.length}"
                                            .text
                                            .make(),
                                      ],
                                    ),
                                    5.widthBox,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        "$currency ${singleOrder.amountPaid}"
                                            .text
                                            .bold
                                            .make(),
                                        5.heightBox,
                                        (singleOrder.status == 0
                                                ? pending
                                                : singleOrder.status == 1
                                                    ? processing
                                                    : singleOrder.status == 3
                                                        ? canceled
                                                        : delivered)
                                            .text
                                            .white
                                            .make()
                                            .paddingAll(5)
                                            .box
                                            .padding(const EdgeInsets.symmetric(
                                                horizontal: 10))
                                            .color(singleOrder.status == 0
                                                ? Colors.red
                                                : singleOrder.status == 2
                                                    ? Colors.purple
                                                    : singleOrder.status == 3
                                                        ? Colors.black
                                                        : Colors.green)
                                            .shadow
                                            .rounded
                                            .make(),
                                        5.heightBox,
                                        DateFormat()
                                            .format(singleOrder.orderDate)
                                            .text
                                            .make(),
                                      ],
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
                                  .make()
                                  .onTap(() {
                                Get.to(() => OrderDetailScreen(
                                      orderData: singleOrder,
                                    ));
                              });
                            }),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: "No orders! Order some".text.size(22).make(),
                );
              }
            }
            return Container();
          }),
    );
  }
}
