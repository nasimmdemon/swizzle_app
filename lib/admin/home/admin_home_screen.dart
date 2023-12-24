import 'package:swizzle/admin/controllers/statistics_controller.dart';
import 'package:swizzle/consts/consts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StatisticsController());
    controller.totalUsers();
    controller.totalOrdersMet();
    controller.totalRevinew();
    return Scaffold(
      appBar: AppBar(
        title: "Admin Home Screen".text.make(),
      ),
      body: GetBuilder(
          init: controller,
          builder: (_) => Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 700,
                    width: 900,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 213, 79, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                          color:
                                              Color.fromRGBO(255, 213, 79, 1))
                                    ]),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: const Icon(Icons.pie_chart),
                                      leading: "Customers".text.size(18).make(),
                                    ),
                                    "${controller.totalCustomers.value}"
                                        .text
                                        .size(40)
                                        .make()
                                  ],
                                )),
                            Container(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(149, 117, 205, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                          color:
                                              Color.fromRGBO(149, 117, 205, 1))
                                    ]),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: const Icon(
                                        Icons.shopping_basket_outlined,
                                        color: whiteColor,
                                      ),
                                      leading:
                                          "Orders".text.white.size(18).make(),
                                    ),
                                    "${controller.totalOrders.value}"
                                        .text
                                        .size(40)
                                        .white
                                        .make()
                                  ],
                                )),
                          ],
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(197, 225, 165, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                          color:
                                              Color.fromRGBO(197, 225, 165, 1))
                                    ]),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing:
                                          const Icon(Icons.monetization_on),
                                      leading: "Revinew".text.size(18).make(),
                                    ),
                                    "Sek 33,43590".text.size(22).make()
                                  ],
                                )),
                            Container(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 138, 101, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                          color:
                                              Color.fromRGBO(255, 138, 101, 1))
                                    ]),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: const Icon(
                                        Icons.cancel,
                                        color: whiteColor,
                                      ),
                                      leading:
                                          "Canceled".text.white.size(18).make(),
                                    ),
                                    "2".text.size(40).white.make()
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
