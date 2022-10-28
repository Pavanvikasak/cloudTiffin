class AllKitchenModel{
  late final String?id;
  late final String name;
  late final String image;
  late final String distance;
  late final String delivery_time;
  late final String open_time;
  late final String close_time;



  AllKitchenModel(
      {
        required this.id,
        required this.name,
        required this.image,
        required this.distance,
        required this.delivery_time,
        required this.open_time,
        required this.close_time,

      });

  AllKitchenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['shop_name'];
    image = json['shop_image'];
    distance = json['latitude'];
    delivery_time = json['delivery_time'] ;
    open_time = json['opening_time'];
    close_time = json['clossing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['shop_name'] = name;
    data['shop_image'] = image;
    data['latitude'] = distance;
    data['delivery_time'] = delivery_time;
    data['opening_time'] = open_time;
    data['clossing_time'] = close_time;

    return data;
  }
}




