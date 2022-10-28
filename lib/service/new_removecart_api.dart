import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../model/cart_models.dart';




class NewRemoveCartApi {
  static late NewRemoveCartApi _instance;

  NewRemoveCartApi._();

  static NewRemoveCartApi get instance {
    _instance = NewRemoveCartApi._();
    return _instance;
  }

  Future<List<CartModel>> put(
      String productId,String userid,String vendorid,String qty) async {


    print('Api all shop ');
    // print('Shoplist shop no. ' + catId);
    // print('Shoplist shop no. ' + longitude );
    // print('Shoplist shop no. '+  latitude );
    // print('Shoplist shop no. ' + distance);
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/remove_cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "product_id"  :   productId  ,
        "user_id"     :     userid,
        "vendor_id"   :     vendorid,
        // "name"        :     name,
        // "price"       :     price,
        "qty"         :     qty,
        // "total_price" :     totalprice,
        // "image"       :     image
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
