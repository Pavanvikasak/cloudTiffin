import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/Quick_category_model.dart';



class QuickCategoryApi {
  static late QuickCategoryApi _instance;

  QuickCategoryApi._();

  static QuickCategoryApi get instance {
    _instance = QuickCategoryApi._();
    return _instance;
  }

  Future<List<QuickCategoryModel>> getAllShop(
      String catId, String distance) async {
    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();

    print('Api all shop ');
    print('Shoplist shop no. ' + catId);
    // print('Shoplist shop no. ' + longitude );
    // print('Shoplist shop no. '+  latitude );
    print('Shoplist shop no. ' + distance);
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/nearby_vendors'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cat_id': catId,
        'longitude': longitude,
        'latitude': latitude,
        'distance': distance,
      }),
    );

    // print('helloooooooooo service listtttttt');
    final data = json.decode(response.body);
    print(data);
    final List responseBody = data['Nearby'];
    print(responseBody);
    // return responseBody.map((e) => ServiceCatModel.fromJson(e)).toList();
    return responseBody.map((e) => QuickCategoryModel.fromJson(e)).toList();
    //   }
  }
}
