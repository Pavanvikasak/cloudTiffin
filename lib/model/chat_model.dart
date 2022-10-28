class ChatModel {
  final String? vendor_id;
  final String? user_id;
  final String? order_id;
  final String? message;
  final String? time;
  //final bool user = false;

  ChatModel(  {required this.vendor_id,required this.user_id,required this.order_id,required this.message,
    required this.time,

  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(

      user_id: json["user_id"],
      vendor_id: json["vendor_id"],
      order_id: json["order_id"],
      message: json["message"],
      time: json["created_at"],


    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['user_id'] = user_id;
    data['vendor_id'] = vendor_id;
    data['order_id'] = order_id;
    data['message'] = message;
    data['created_at'] = time;


    return data;
  }
}