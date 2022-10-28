import 'dart:convert';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/routes.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:cloud_tiffin/model/NewAllKitchenModel.dart';
import 'package:cloud_tiffin/provider/get_cart_data_provider.dart';
import 'package:cloud_tiffin/provider/new_cart_provider.dart';
import 'package:cloud_tiffin/provider/new_remove_cart_provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../config.dart';
import '../controllers/cart_controller.dart';
import '../model/cart_models.dart';
import 'package:cloud_tiffin/global.dart' as globals;

class KitchenAddButton extends StatefulWidget {
  // final CartModel? cartModel ;

  final String? price;
  final String? vendorid;
  final String? productid;
  final String? qty;
  final String? leftqty;
  final String? userid;
  final String? image;
  final String? totalprice;
  final String? name;
  final String? index;
  final String? globalid;
  final bool? isSelected;
  final int? isQty;

  const KitchenAddButton(
      {Key? key,
        this.leftqty,
        this.index,
        this.name,
        this.qty,
        this.image,
        this.price,
        this.userid,
        this.productid,
        this.totalprice,
        this.vendorid,
        this.globalid,
        this.isSelected,
        this.isQty})
      : super(key: key);

  @override
  State<KitchenAddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<KitchenAddButton> {
  bool isVisible = true;
  bool? isselected;
  NewAllKitchenModel? kitchenModel;

  @override
  initState() {
    super.initState();
    _get_session();
    // setState(() {
    //   isselected = widget.isSelected;
    // });
  }

  String? user_id;

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id');
  }

  double total_price = 0.0;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return

      // (isVisible)? Padding(
      // padding:
      // const EdgeInsets
      //     .all(12),
      // child: InkWell(
      //   onTap: () {
      //    // globals.isVendorSelected == true ?
      //    // globals.isVendorSelectedId == widget.vendorid?
      //
      //
      //      //showDataAlert(context):setState(() {
      //   //  }) :  showDataAlert(context):
      //         setState(() {
      //
      //       // isVisible = false;
      //
      //
      //
      //
      //       add_cart(widget.price, widget.productid!,user_id,widget.totalprice!,widget.image!,widget.vendorid!,
      //           "$_counter", widget.name!);
      //       // NewCartProvider.initial(
      //       //     price:
      //       //     widget.price,
      //       //     productId:
      //       //     widget.productid!,
      //       //     userid:
      //       //     "$user_id",
      //       //     totalprice:
      //       //     widget.totalprice!,
      //       //     image: widget.image!,
      //       //     vendorid:widget.vendorid!,
      //       //     qty:"$_counter",
      //       //     name: widget.name!);
      //     });
      //
      //     // Totalitem.add();
      //
      //     /// ========================================================================
      //     /// ===================================================================================
      //   },
      //   child: Container(
      //     width: 86,
      //     height: 32,
      //     alignment: Alignment
      //         .center,
      //     decoration: BoxDecoration(
      //         color: Colors
      //             .white,
      //         borderRadius:
      //         BorderRadius
      //             .circular(
      //             12),
      //         border: Border.all(
      //             color:
      //             kredColor,
      //             width: 1)),
      //     child: kTextstyle(
      //         myText: 'add +',
      //         mySize: 14,
      //         myWeight:
      //         FontWeight
      //             .w500),
      //   ),
      // ),
      // ) :
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onLongPress: (){
                      _counter--;


                      remove_cart(widget.productid, user_id, widget.vendorid);

                    },
                    onTap: () {
                      setState(() {
                        // cart.addQty();
                        _counter--;


                        remove_cart(widget.productid, user_id, widget.vendorid);


                        // NewRemoveCartProvider.initial(
                        //   productId: widget.productid! ,
                        //   userid: "$user_id" ,
                        //   vendorid: widget.vendorid!,
                        //   qty:"$_counter",
                        // );

                        if (_counter < 1) {
                          _counter = 0;
                          remove_cart(widget.productid, user_id, widget.vendorid);
                          // deleteDatabase( )
                          isVisible = true;
                        }
                      });
                    },
                    child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                            color: kwhiteColor,
                            boxShadow: [
                              BoxShadow(
                                  color: kblackcolor.withOpacity(0.15),
                                  offset: Offset(0, 1),
                                  blurRadius: 3)
                            ],
                            shape: BoxShape.circle),
                        child: Icon(Icons.remove))),
                Consumer<GetCartProvider>(
                  builder: (_, data, __) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 18,
                        height: 24,
                        child:
                        kTextstyle(myText: _counter.toString(), mySize: 16),
                      ),
                    );
                  },
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (
                        _counter < int.parse(widget.leftqty!)) {
                          // isVisible=false;
                          _counter++;
                          add_cart(
                              widget.price,
                              widget.productid!,
                              user_id,
                              widget.totalprice!,
                              widget.image!,
                              widget.vendorid!,
                              "$_counter",
                              widget.name!);
                        } else {
                          // _counter = int.parse(widget.leftqty!);
                          isVisible = true;
                        }
                        // NewCartProvider.initial(
                        //     price:
                        //     widget.price,
                        //     productId:
                        //     widget.productid!,
                        //     userid:
                        //     "$user_id",
                        //     totalprice:
                        //     widget.totalprice!,
                        //     image: widget.image!,
                        //     vendorid:widget.vendorid!,
                        //     qty:"$_counter",
                        //     name: widget.name!);}
                      });
                    },
                    child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                            color: kwhiteColor,
                            boxShadow: [
                              BoxShadow(
                                  color: kblackcolor.withOpacity(0.15),
                                  offset: Offset(0, 1),
                                  blurRadius: 3)
                            ],
                            shape: BoxShape.circle),
                        child: Icon(Icons.add)))
              ],
            ),
          ),
        ),
      );
  }

  Future add_cart(
      price, productid, user_id, totalprice, image, vendorid, qty, name) async {
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/add_cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "product_id": productid,
        "user_id": user_id,
        "vendor_id": vendorid,
        "name": name,
        "price": price,
        "qty": "$qty",
        "total_price": totalprice,
        "image": image
      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      // if(isVisible)
      setState(() {
        //  _counter++;
        isVisible = !isVisible;
      });
      CartController cartController=Get.find(tag: "cart");
      cartController.dataList.refresh();
      cartController.getData();
      print(data['ResponseMsg']);
    } else {
      print(data['ResponseMsg']);

      showDataAlert(context, productid, user_id, vendorid);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("${data['ResponseMsg']}"),
      // ));

    }
  }

  Future remove_cart(productid, user_id, vendorid) async {
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/remove_cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "product_id": productid,
        "user_id": user_id,
        "vendor_id": vendorid,
      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      print(data['ResponseMsg']);
      CartController cartController=Get.find(tag: "cart");
      cartController.dataList.refresh();
      cartController.getData();
      // setState(() {
      //   _counter--;
      // });
    } else {
      print(data['ResponseMsg']);
    }
  }

  Future delete_cart(productid, user_id, vendorid) async {
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/delete_cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // "product_id"  :   productid  ,
        "user_id": user_id,
        //  "vendor_id"   :     vendorid,
      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {

      print(data['ResponseMsg']);
      CartController cartController=Get.find(tag: "cart");
      cartController.dataList.clear();
      cartController.getData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${data['ResponseMsg']}"),
      ));
      // setState(() {
      //   _counter--;
      // });
      Navigator.of(context).pop();
    } else {
      print(data['ResponseMsg']);
    }
  }

  showDataAlert(context, productid, user_id, vendorid) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Column(
              children: [
                kTextstyle(
                    myText: "Your cart has product with ",
                    mySize: 16,
                    space: 0.2,
                    myWeight: FontWeight.w600,
                    myColor: kgreyColor),
                kTextstyle(
                    myText: "diffrent kitchen provider",
                    mySize: 16,
                    space: 0.2,
                    myWeight: FontWeight.w600,
                    myColor: kgreyColor),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                      width: 120,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kredColor,
                          // fixedSize: Size(250, 50),
                        ),
                        child: Text(
                          "Back",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        delete_cart(productid, user_id, vendorid);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kredColor,
                        // fixedSize: Size(250, 50),
                      ),
                      child: Text(
                        "Clear Cart",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
