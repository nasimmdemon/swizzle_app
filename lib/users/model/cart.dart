// ignore_for_file: non_constant_identifier_names

class Cart {
  int cart_id;
  int user_id;
  int item_id;
  int item_qty;
  double item_price;
  double sale_price;
  String item_name;
  String item_image;

  Cart(
    this.cart_id,
    this.user_id,
    this.item_id,
    this.item_qty,
    this.item_price,
    this.sale_price,
    this.item_name,
    this.item_image,
  );

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      int.parse(json['cart_id']),
      int.parse(json['user_id']),
      int.parse(json['item_id']),
      int.parse(json['item_qty']),
      double.parse(json['item_price']),
      double.parse(json['sale_price']),
      json['item_name'],
      json['item_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'cart_id': cart_id.toString(),
        'user_id': user_id.toString(),
        'item_id': item_id.toString(),
        'item_qty': item_qty.toString(),
        'item_price': item_price.toString(),
        'sale_price': sale_price.toString(),
        'item_name': item_name,
        'item_image': item_image,
      };
}
