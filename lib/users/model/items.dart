// ignore_for_file: non_constant_identifier_names

class Item {
  int item_id;
  String item_name;
  String item_description;
  double item_price;
  double item_sale_price;
  int items_status;
  String item_type;
  String item_image;

  Item(this.item_id, this.item_name, this.item_description, this.item_price,
      this.item_sale_price, this.items_status, this.item_type, this.item_image);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        int.parse(json['item_id']),
        json['item_name'],
        json['item_description'],
        double.parse(json['item_price']),
        double.parse(json['sale_price']),
        int.parse(json['item_status']),
        json['item_type'],
        json['item_image'],
      );
}
