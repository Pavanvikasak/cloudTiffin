// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// class DbHelperr {
//   static late Database _database;
//
//   Future openDb() async {
//     _database = await openDatabase(
//
//         join(await getDatabasesPath(), "ss.db"),
//         version: 1, onCreate: (Database db, int version) async {
//       await db.execute(
//         "CREATE TABLE cart(id INTEGER PRIMARY KEY , name TEXT, course TEXT)",
//       );
//     });
//   }
//
//   Future<int> insertCart(Cart cart) async {
//     await openDb();
//     return await _database.insert('cart', cart.toMap());
//   }
//
//   Future<List<Cart>> getCartList() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database.query('cart');
//     return List.generate(maps.length, (i) {
//       return Cart(
//           id: maps[i]['id'], name: maps[i]['name'], image: maps[i]['image']);
//     });
//   }
//
//   Future<int> updateCart(Cart cart) async {
//     await openDb();
//     return await _database
//         .update('cart', cart.toMap(), where: "id = ?", whereArgs: [cart.id]);
//   }
//
//   Future<void> deleteCart(int id) async {
//     await openDb();
//     await _database.delete('cart', where: "id = ?", whereArgs: [id]);
//   }
// }
//
// class Cart {
//   late int id;
//   late String name;
//   late String image;
//
//   Cart({required this.name, required this.image, required this.id});
//
//   Map<String, dynamic> toMap() {
//     return {'name': name, 'image': image, 'id': id};
//   }
// }
