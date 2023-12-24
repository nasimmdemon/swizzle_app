// ignore_for_file: non_constant_identifier_names

class UserInfo {
  String user_name;
  String user_email;
  String full_name;
  int zip_code;
  String address;
  String city_town;
  int contact_number;

  UserInfo(
    this.user_name,
    this.user_email,
    this.full_name,
    this.zip_code,
    this.address,
    this.city_town,
    this.contact_number,
  );

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        json['user_name'],
        json['user_email'],
        json['full_name'],
        int.parse(json['zip_code']),
        json['address'],
        json['city_town'],
        int.parse(json['contact_number']));
  }

  Map<String, dynamic> toJson() => {
        'user_name': user_name,
        'user_email': user_email,
        'full_name': full_name,
        'zip_code': zip_code.toString(),
        'address': address,
        'city_town': city_town,
        'contact_number': contact_number.toString(),
      };
}
