class ShopModel {
  int? id;
  String str_shop_name; // shop 이름
  String str_phone;
  String str_shop_url;
  String str_desc;
  String str_image_url;
  bool? b_online;
  bool? b_offline;
  bool? b_domestic;
  bool? b_international;
  String str_address;
  String str_lat;
  String str_long;
  Map<String, dynamic> json_brand;
  DateTime? created_at;

  ShopModel({
    this.id,
    required this.str_shop_name,
    required this.str_phone,
    required this.str_shop_url,
    required this.str_desc,
    required this.str_image_url,
    this.b_online,
    this.b_offline,
    this.b_domestic,
    this.b_international,
    required this.str_address,
    required this.str_lat,
    required this.str_long,
    required this.json_brand,
    this.created_at,
  });

  // factory ShopModel.fromJson(Map<String, dynamic> json) {}
}
