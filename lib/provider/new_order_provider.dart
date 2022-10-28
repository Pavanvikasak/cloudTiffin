// import 'package:demo/service/all_shop_api.dart';
import 'package:cloud_tiffin/service/New_order_cart_api.dart';
import 'package:cloud_tiffin/service/quick_category_api.dart';
import 'package:flutter/widgets.dart';

import '../model/Quick_category_model.dart';
import '../model/cart_models.dart';
import '../service/new_cart_api.dart';

// import '../aaa/Seller_model.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class NewOrderProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CartModel> OrderDetails = [];
  String message = '';

  // String vendorid = '';

  // var catid = '';
  NewOrderProvider() {}

  NewOrderProvider.initial(
      {String? userid, String? vendorid,
        String? address, String? totalprice, order_date}) {
    // print(vendorid);
    _fetchShop(address!, userid!, vendorid!, order_date, totalprice!,
        );
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchShop(String userid, String vendorid,
      String address, String totalprice, order_date) async {
    _homeState = HomeState.loading;
    try {
      final QuickCatApi = await placeOrderApi.instance.put(
           userid, vendorid,address, totalprice, order_date);
      OrderDetails = QuickCatApi;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }


}




// class CartModel {
//   final String vendor_id;
//   final String user_id;
//   final String product_id;
//   // final String CatId;
//   final String name;
//   final String price;
//   final String? total_price;
//   final int qty;
//   final String image;
//
//   CartModel(
//       {required this.user_id,
//       this.total_price, //
//       required this.vendor_id, //
//       required this.product_id, //
//       // required this.CatId,
//       required this.name, //
//       required this.price, //
//       required this.qty, //
//       required this.image}); //
//
//   factory CartModel.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return CartModel(
//       user_id: json["user_id"],
//       vendor_id: json["vendor_id"],
//       product_id: json["product_id"],
//       name: json["name"],
//       price: json["price"],
//       // CatId: json["catId"],
//       qty: json["qty"], image: json["image"],
//
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     "user_id": user_id,
//     "vendor_id": vendor_id,
//     "product_id": product_id,
//     "name": name,
//     "price": price,
//     // "CatId": CatId,
//     "qty": qty,
//     "image": image
//     return map;
//   // toMap() => {
//   //       "user_id": user_id,
//   //       "vendor_id": vendor_id,
//   //       "product_id": product_id,
//   //       "name": name,
//   //       "price": price,
//   //       // "CatId": CatId,
//   //       "qty": qty,
//   //       "image": image
//   //     };
// }
