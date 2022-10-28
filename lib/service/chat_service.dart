import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/cart_models.dart';
import '../model/chat_model.dart';

class ChatService {


  static List<ChatModel> dataFromJson(String jsonString) {

    final data = json.decode(jsonString);
    print("hey cart length ${data.length} ");
    return List<ChatModel>.from(
        data.map((item) => CartModel.fromJson(item)));
  }
  // static Future getDataById({required String pid}) async {
  //   final response = await http.get(Uri.parse("$_getPByIdUrl/$pid"));
  //   if(response.body=="null")
  //     return "error";
  //   else{
  //     // try{
  //     if (response.statusCode == 200) {
  //       final jsonRes=await json.decode(response.body);
  //       return jsonRes;
  //     } else {
  //       return "error"; //if any error occurs then it return a blank list
  //     }
  //   }
  //
  // }
  static Future<List<ChatModel>> getData() async {
    print("hey cart 6");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user_id = preferences.getString("id") ?? "";

    //   final response = await http.get(Uri.parse("${Config.BASEURL}user/getCartdata"));
    final response = await http.post(
      Uri.parse('${Config.BASEURL}user/get_message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": '$user_id',}),
    );
    //  final response = await http.get(Uri.parse("$_viewUrl/$uid"));
    if(response.body=="null")
      return [];
    else{
      // try{
      if (response.statusCode == 200) {
        print("hey cart 7");
        //final data = json.decode(response.body);
        //  print("Cart data");
        //  print(data);
        // final  responseBody = data['cartDetails'];
        //  List<CartModel> list = dataFromJson(data['cartDetails']);
        // return  responseBody.map((e) => CartModel.fromJson(e)).toList();
        List<ChatModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    }

  }

}
