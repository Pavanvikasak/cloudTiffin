// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart';
//
// class DBHelper {
//
// //
// //   DBHelper._privateConstuctor();
// // static  final instance = DBHelper._privateConstuctor();
//   static  Database? _db;
//
//   Future<Database?> get db async {
//     if (_db != null) {
//       _db = await initDatabase();
//       return _db;
//     }
//
//     print('init database');
//     // return _db;
//   // print('db initialize');
//   }
//
//   initDatabase() async {
//     io.Directory directory = await getApplicationDocumentsDirectory();
//     print('db location : ' + directory.path);
//     String path = join(directory.path, 'TABLE.db');
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId INTEGER ,productName Text,productPrice INTEGER,initialprice INTEGER,productImage TEXT)');
//   }
//
//   Future<Cart> insert(Cart cart) async {
//     var dbClient = await db;
//     await dbClient!.insert('cart', cart.toMap());
//     return cart;
//   }
//
//   Future<List<Cart>> getCartList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
//     return queryResult.map((e) => Cart.fromMap(e)).toList();
//   }
// }
//
// ///model class for the the  database cart
// ///
// class Cart {
//   late int id;
//   late int productId;
//   late String productName;
//   late int initialprice;
//   late int productPrice;
//   late String productImage;
//
//   Cart(
//       {required this.productName,
//       required this.productPrice,
//       required this.initialprice,
//       required this.productId,
//       required this.productImage,
//       required this.id});
//
//   Cart.fromMap(Map<dynamic, dynamic> res)
//       : id = res['id'],
//         productPrice = res['productPrice'],
//         productImage = res['productImage'],
//         initialprice = res['initialprice'],
//         productId = res['productId'],
//         productName = res['productName'];
//
//   Map<String, dynamic> toMap() {
//     return {
//       'productName': productName,
//       'productId': productId,
//       'productPrice': productPrice,
//       'initialprice': initialprice,
//       'productImage': productImage,
//       'id': id
//     };
//   }
// }
