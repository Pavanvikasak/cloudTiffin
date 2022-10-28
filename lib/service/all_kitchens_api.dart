import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/NewAllKitchenModel.dart';
import '../model/all_kitchen_model.dart';

class AllKitchenApi {
  static late AllKitchenApi _instance;

  AllKitchenApi._();
  static AllKitchenApi get instance {
    _instance = AllKitchenApi._();
    return _instance;
  }


  Future<List<NewAllKitchenModel>?> getAllKitchen() async {
    print('helloooooooooo');
    var response = await  http.get(Uri.parse('${Config.BASEURL}user/all_vendors'));
    //var response = await  http.get(Uri.parse('https://easemysalon.info/flutter_api/user/categories_list'));




    final data = json.decode(response.body);

    final  List responseBody = data['Allkitchen'];
    print(responseBody);
    return responseBody.map((e) => NewAllKitchenModel.fromJson(e)).toList();

  }
}