import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart'as http;

import '../config.dart';
import '../model/CategoryModel.dart';

class AllCategoryApi{
  static late AllCategoryApi _instance;
  AllCategoryApi._();
  static AllCategoryApi get instance{
    _instance = AllCategoryApi._();
    return _instance;
  }
  Future<List<CategoryModel>?>getAllCategory() async{
    var response = await http.get(Uri.parse('${Config.BASEURL}user/categories_list'));
    final data = json.decode(response.body);
    final List responseBody =data['ServiceData'];
    return responseBody.map((e) => CategoryModel.fromJson(e)).toList();

  }
}