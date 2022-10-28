class CategoryServicesModel{
  late final String? user_id;
  late final String? vendor_id;
  late final String? product_id;
  late final String total_price;
  late final String product_name;
  late final String image;
  late final String quantity;
  late final String delivery_type;
  late final String actual_price;
  late final String offer_price;
  late final String service_time;
  bool? isSelected;




  CategoryServicesModel(
      {
        required this.user_id,
        required this.vendor_id,
        required this.product_id,
        required this.total_price,
        required this.product_name,
        required this.image,
        required this.quantity,
        required this.delivery_type,
        required this.actual_price,
        required this.offer_price,
        required this.service_time,
        required this.isSelected,


      });

  CategoryServicesModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    vendor_id = json['vendor_id'];
    product_id = json['product_id'];
    total_price = json['total_price'];
    product_name = json['product_name'];
    quantity = json['quantity'];
    delivery_type = json['delivery_type'];
    image = json['thumbnail'];
    actual_price = json['actual_price'];
    offer_price = json['offer_price'];
    service_time = json['service_time'];
    isSelected = false;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = user_id;
    data['vendor_id'] = vendor_id;
    data['product_id'] = product_id;
    data['product_name'] = product_name;
    data['total_price'] = total_price;
    data['thumbnail'] = image;
    data['quantity'] = quantity;
    data['delivery_type'] = delivery_type;
    data['actual_price'] = actual_price;
    data['offer_price'] = offer_price;
    data['service_time'] = service_time;
    data['false'] = isSelected;


    return data;
  }
}
