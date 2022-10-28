import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/CategoryModel.dart';
import '../model/NewAllKitchenModel.dart';
import '../model/cart_models.dart';
import '../model/kitchen_model.dart';

class CategoryService {


  static List<CategoryModel> dataFromJson(String jsonString) {

   //var responseBody =jsonString['ServiceData'];
    final data = json.decode(jsonString);
    print("category/////////////////////$data");
    return List<CategoryModel>.from(
        data.map((item) => CategoryModel.fromJson(item)));
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
  static Future<List<CategoryModel>> getData() async {
    print("hey category 6");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user_id = preferences.getString("id") ?? "";

    final response = await http.get(Uri.parse("${Config.BASEURL}user/categories_list2"));


    if(response.body=="null")
      return [];
    else{
      // try{
      if (response.statusCode == 200) {
        print("hey category 7");



        List<CategoryModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    }

  }



}
