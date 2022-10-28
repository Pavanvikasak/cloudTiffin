class CartModel {
  final String? vendor_id;
  final String? user_id;
  final String? product_id;
  // final String CatId;
  final String? name;
  final String? price;
  final String? total_price;
  final String? qty;
  final String? image;
  final String? address;
  final String? order_date;

  CartModel({
    required this.order_date,
    required this.address,
    required this.user_id,
    required this.total_price,
    required this.vendor_id,
    required this.product_id,
    // required this.CatId,
    required this.name,
    required this.price,
    required this.qty,
    required this.image
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(

      user_id: json["user_id"],
      vendor_id: json["vendor_id"],
      product_id: json["product_id"],
      name: json["name"],
      price: json["price"],
      total_price: json["total_price"],
      // CatId: json["catId"],
      qty: json["qty"],
      image: json["image"],
      address: json["address"],
      order_date: json["order_date"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['user_id'] = user_id;
    data['vendor_id'] = vendor_id;
    data['product_id'] = product_id;
    data['name'] = name;
    data['price'] = price;
    data['total_price'] = total_price;
    data['qty'] = qty;
    data['image'] = image;
    data['address'] = address;
    data['order_date'] = order_date;

    //data['updated_at'] = totalSalon;
    // data['url'] = isSelected;
    // data['value'] = services;

    return data;
  }
}