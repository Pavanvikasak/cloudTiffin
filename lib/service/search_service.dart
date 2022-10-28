import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/NewAllKitchenModel.dart';
import '../model/cart_models.dart';
import '../model/kitchen_model.dart';
import '../model/search_model.dart';

class SearchService {


  static List<SearchModel> dataFromJson(String jsonString) {
    // final  List responseBody = data['Allkitchen'];
    final data = json.decode(jsonString);
    print("kictchen/////////////////////$data");
    return List<SearchModel>.from(
        data.map((item) => SearchModel.fromJson(item)));
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
  static Future<List<SearchModel>> getData(String id) async {
    print("hey 6");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uuser_id = preferences.getString("id") ?? "";

   // final response = await http.get(Uri.parse("${Config.BASEURL}user/get_vendor_by_id"));
    final response = await  http.post(
      Uri.parse('${Config.BASEURL}user/get_vendor_by_id'),
      // Uri.parse('https://thesoftwareplanet.com/aayra/flutter_api/user/fiverbookService'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'vendor_id': "$id",



      }),
    );

    if(response.body=="null")
      return [];
    else{
      // try{
      if (response.statusCode == 200) {
        print("hey 7");



        List<SearchModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    }

  }



}
