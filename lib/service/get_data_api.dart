import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/Quick_category_model.dart';
import '../model/cart_models.dart';
import '../provider/new_cart_provider.dart';



class GetCartApi {
  static late GetCartApi _instance;

  GetCartApi._();

  static GetCartApi get instance {
    _instance = GetCartApi._();
    return _instance;
  }


    Future<List<CartModel>?> getAllCart(String userid) async{


    print('Api get data ');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/getCartdata'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": userid}),
    );

    final data = json.decode(response.body);
  //  print(data);
    final List responseBody = data['cartDetails'];
    print("helllo cart data........$responseBody");
    return responseBody.map((e) => CartModel.fromJson(e)).toList();
    //   }
  }
}
