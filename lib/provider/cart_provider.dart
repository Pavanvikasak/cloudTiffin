// import 'dart:math';
//
// import 'package:cloud_tiffin/model/NewAllKitchenModel.dart';
// import 'package:flutter/material.dart';
//
// import '../model/Quick_category_model.dart';
//
// class CartProvider extends ChangeNotifier {
//   List<CartModel> SelectedProduct = [];
//   double total_price = 0.0;
//   int _counter = 0;
//   int get counter => _counter;
//
//   addtoCart(CartModel cartModel) {
//     bool kk = SelectedProduct.contains(cartModel);
//     if (SelectedProduct.isEmpty) {
//       SelectedProduct.add(cartModel);
//       // total_price += double.parse(cartModel.id);
//       print(' added to cart  $total_price');
//       print(' added to cart  ${SelectedProduct.length}');
//     } else {
//       print(kk);
//       // if(detail == false)
//       // {
//       //
//       //
//       // }
//     }
//
//     notifyListeners();
//   }
//
//   itemCount() {
//     var data = SelectedProduct.length;
//
//     return data;
//   }
//
//   addQty() {
//     _counter++;
//   }
//
//   removeQty() {
//     _counter--;
//     // qty =cartModel.Qty;
//     notifyListeners();
//   }
//
//   clearCart() {
//     SelectedProduct.clear();
//     total_price = 0;
//     print('data clear');
//     notifyListeners();
//   }
// }
//
//
//
// // import 'package:cloud_tiffin/helper/dbhelper.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class CartProvider with ChangeNotifier{
// //
// //   // DBHelper db =DBHelper();
// //   int _counter = 0;
// //   int get counter => _counter;
// //
// //   int _totalPrice =0;
// //   int get totalPrice =>_totalPrice;
// //
// //   // late Future<List<Cart>>_cart;
// //   // Future<List<Cart>> get cart => _cart;
// //   //
// //   // Future<List<Cart>> getData() async {
// //   //   _cart = db.getCartList();
// //   //   return _cart;
// //   // }
// //
// //
// //
// //
// //
// //
// //   void _setPrefItems()async{
// //     SharedPreferences prefs =await SharedPreferences.getInstance();
// //      prefs.setInt('cart_item', _counter);
// //      prefs.setInt('total_price', _totalPrice);
// //      notifyListeners();
// //   }
// // void _getPrefItem() async{
// //     SharedPreferences prefs =await SharedPreferences.getInstance();
// //     _counter = prefs.getInt('total_price')?? 0;
// //     _totalPrice =prefs.getInt('total_price')??0;
// //     notifyListeners();
// //
// // }
// // void addCounter(){
// //     _counter++;
// //     _setPrefItems();
// //     notifyListeners();
// // }
// // void removeCounter(){
// //     _counter--;
// //     _setPrefItems();
// //     notifyListeners();
// // }
// // int getCounter(){
// //   _getPrefItem();
// //     return _counter;
// // }
// //   void addTotalPrice(int productPrice){
// //     _totalPrice =_totalPrice + productPrice;
// //     _setPrefItems();
// //     notifyListeners();
// //   }
// //   void removeTotalPrice(int productPrice){
// //     _totalPrice =_totalPrice - productPrice;
// //     _setPrefItems();
// //     notifyListeners();
// //   }
// //   int getTotalPrice(){
// //     _getPrefItem();
// //     return _totalPrice;
// //   }
// //
// //
// // }
//
// class NewCartModel {
//   String? id;
//   String? name;
//
//   // String? email;
//
//   List<Products>? products;
//
//   NewCartModel({
//     this.id,
//     this.name,
//     // this.email,
//     this.products,
//   });
//
//   NewCartModel.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     // email = json['email'];
//
//     if (json['products'] != null) {
//       products = [];
//       json['products'].forEach((v) {
//         products?.add(Products.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     // map['email'] = email;
//
//     if (products != null) {
//       map['products'] = products?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class Products {
//   Products({
//     this.id,
//     this.name,
//     this.vendorId,
//     this.categoryId,
//     this.image,
//     this.qty,
//     this.price,
//   });
//
//   Products.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     vendorId = json['vendor_id'];
//     categoryId = json['category_id'];
//     qty = json['qty'];
//     price = json['price'];
//   }
//
//   String? id;
//   String? name;
//   String? vendorId;
//   String? categoryId;
//   String? image;
//   String? qty;
//   String? price;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['vendor_id'] = vendorId;
//     map['category_id'] = categoryId;
//     map['image'] = image;
//     map['qty'] = qty;
//     map['price'] = price;
//
//     return map;
//   }
// }
