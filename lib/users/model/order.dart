import 'dart:convert';

class Order {
  int orderId;
  int userId;
  List<dynamic> selectedItems;
  double totalPrice;
  double deliveryFee;
  String shippingMethod;
  double amountPaid;
  String paymentMethod;
  DateTime orderDate;
  String orderNote;
  String fullName;
  String address;
  String cityTown;
  String zipCode;
  int contactNumber;
  int status;

  Order({
    required this.orderId,
    required this.userId,
    required this.selectedItems,
    required this.totalPrice,
    required this.deliveryFee,
    required this.shippingMethod,
    required this.amountPaid,
    required this.paymentMethod,
    required this.orderDate,
    required this.orderNote,
    required this.fullName,
    required this.address,
    required this.cityTown,
    required this.zipCode,
    required this.contactNumber,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      orderId: int.parse(json['order_id']),
      userId: int.parse(json['user_id']),
      selectedItems: jsonDecode(json['selected_items']),
      totalPrice: double.parse(json['total_price']),
      deliveryFee: double.parse(json['delivery_fee']),
      shippingMethod: json['shipping_method'],
      amountPaid: double.parse(json['amount_paid']),
      paymentMethod: json['payment_method'],
      orderDate: DateTime.parse(json['order_date']),
      orderNote: json['order_note'],
      fullName: json['full_name'],
      address: json['address'],
      cityTown: json['city_town'],
      zipCode: json['zip_code'],
      contactNumber: int.parse(json['contact_number']),
      status: int.parse(json['status']));
}
