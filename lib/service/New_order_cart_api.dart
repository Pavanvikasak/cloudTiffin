import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/Quick_category_model.dart';
import '../model/cart_models.dart';
import '../provider/new_cart_provider.dart';

class placeOrderApi {
  static late placeOrderApi _instance;

  placeOrderApi._();

  static placeOrderApi get instance {
    _instance = placeOrderApi._();
    return _instance;
  }

  Future<List<CartModel>> put(String userid, String vendorid,
      String address, String totalprice, order_date) async {
    print('Api all shop ');
    // print('Shoplist shop no. ' + catId);
    // print('Shoplist shop no. ' + longitude );
    // print('Shoplist shop no. '+  latitude );
    // print('Shoplist shop no. ' + distance);
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/place_order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": userid,
        "vendor_id": vendorid,

        "address": address,
        "total_price": totalprice,
        "order_date": order_date
      }),
    );

    // print('helloooooooooo service listtttttt');
    final data = json.decode(response.body);
    print(data);
    final List responseBody = data['Cart_status'];
    print(responseBody);
    // return responseBody.map((e) => ServiceCatModel.fromJson(e)).toList();
    return responseBody.map((e) => CartModel.fromJson(e)).toList();
    //   }
  }
}
