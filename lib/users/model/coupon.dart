// ignore_for_file: non_constant_identifier_names

class Coupon {
  int id;
  String code;
  String type;
  double amount;
  String expiryDate;
  int status;

  Coupon(
      this.id, this.code, this.type, this.amount, this.expiryDate, this.status);

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
      int.parse(json['id']),
      json['code'],
      json['type'],
      double.parse(json['amount']),
      json['expiry_date'],
      int.parse(json['status']));
}
