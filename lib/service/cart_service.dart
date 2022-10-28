import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/cart_models.dart';

class CartService {
  static List<CartModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    print("hey cart length ${data.length} ");
    return List<CartModel>.from(data.map((item) => CartModel.fromJson(item)));
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
  static Future<List<CartModel>> getData() async {
    print("hey cart 6");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user_id = preferences.getString("id") ?? "";

    //   final response = await http.get(Uri.parse("${Config.BASEURL}user/getCartdata"));
    final response = await http.post(
      Uri.parse('${Config.BASEURL}user/getCartdata2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": '$user_id',
      }),
    );
    //  final response = await http.get(Uri.parse("$_viewUrl/$uid"));
    if (response.body == "null")
      return [];
    else {
      // try{
      if (response.statusCode == 200) {
        print("hey cart 7");
        //final data = json.decode(response.body);
        //  print("Cart data");
        //  print(data);
        // final  responseBody = data['cartDetails'];
        //  List<CartModel> list = dataFromJson(data['cartDetails']);
        // return  responseBody.map((e) => CartModel.fromJson(e)).toList();
        List<CartModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    }
  }

  static Future DeleteData({String? productId, String? vendorId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("///////////////////// $productId");
    final uid = preferences.getString("id") ?? "";
    final response = await http.post(
      Uri.parse('${Config.BASEURL}user/delete_cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "product_id": "$productId",
        "user_id": "$uid",
        "vendor_id": "$vendorId"
      }),
    );

    print("///////////////////// ${response.body}");
  }

  static Future DeleteAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uid = preferences.getString("id") ?? "";
    final response = await http.put(
        Uri.parse("${Config.BASEURL}user/delete_cart"),
        body: {"user_id": uid});
  }

  // static Future addDataDetails({required String proId,required String amount,
  //   required String qty}) async {
  static Future addDataDetails(String productId, String userid, String vendorid,
      String name, String price, String qty, String totalprice, image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uid = preferences.getString("id") ?? "";
    // final uName=preferences.get("uName")??"";
    final response =
        await http.post(Uri.parse("${Config.BASEURL}user/add_cart"), body: {
      "product_id": productId,
      "user_id": userid,
      "vendor_id": vendorid,
      "name": name,
      "price": price,
      "qty": qty,
      "total_price": totalprice,
      "image": image
    });
    if (response.statusCode == 200) {
      print("response ${response.body}");
      return response.body;
    } else
      return "error";

    // if (response.statusCode == 200) {
    //   final jsonData=await json.decode(response.body);
    //   return jsonData;
    // } else {
    //   return []; //if any error occurs then it return a blank list
    // }
  }
}
