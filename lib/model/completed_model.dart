class CompletedModel {
  final String? id;

  final String? price;
  final String? status;
  final String? created_at;
  // final String? payment_status;
  //
  // final String? payment_type;
  final String? order_id;
  List user_details;
  List products;


  CompletedModel({
    this.id,

    this.price,
    this.status,
    this.created_at,
    // this.payment_status,
    //
    // this.payment_type,
    this.order_id,
    required this.user_details,
    required this.products,
  });

  factory CompletedModel.fromJson(Map<String, dynamic> json) {
    return CompletedModel(


      id: json['id'] ?? "",
      price: json['price'] ?? '',
      status: json['status'] ?? '',
      created_at: json['created_at'] ?? '',
      // payment_status: json['payment_status'] ?? '',
      //
      // payment_type: json['payment_type'] ?? "",
      order_id: json['order_id'] ?? "",
      user_details: json['user_details'] ?? "",
      products: json['products'] ?? "",


    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();

    data['id'] =   id;
    data['price'] =  price;
    data['status'] = status;
    data['created_at'] = created_at;
    // data['payment_status'] =  payment_status;
    //
    // data['payment_type'] = payment_type;
    data['order_id'] = order_id;
    data['user_details'] = user_details;
    data['products'] =products;


    return data;
  }
}
