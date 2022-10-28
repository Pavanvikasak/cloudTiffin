import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/NewAllKitchenModel.dart';
import '../model/cart_models.dart';
import '../model/kitchen_model.dart';

class KitchenService {


  static List<NewAllKitchenModel> dataFromJson(String jsonString) {
   // final  List responseBody = data['Allkitchen'];
    final data = json.decode(jsonString);
    print("kictchen/////////////////////$data");
    return List<NewAllKitchenModel>.from(
        data.map((item) => NewAllKitchenModel.fromJson(item)));
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
  static Future<List<NewAllKitchenModel>> getData() async {
    print("hey 6");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user_id = preferences.getString("id") ?? "";

     // final response = await http.get(Uri.parse("${Config.BASEURL}user/all_vendors2"));
    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();




    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/all_vendors3'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'longitude': longitude,
        'latitude': latitude,
        'distance': '10',
      }),
    );

    if(response.body=="null")
      return [];
    else{
      // try{
      if (response.statusCode == 200) {
        print("hey 7");



        List<NewAllKitchenModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    }

  }



}
