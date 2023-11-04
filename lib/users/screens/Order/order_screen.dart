import 'package:swizzle/consts/consts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: order.text.make(), centerTitle: true),
    );
  }
}
