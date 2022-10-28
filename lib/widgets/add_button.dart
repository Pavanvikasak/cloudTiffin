import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/routes.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:cloud_tiffin/provider/new_cart_provider.dart';
import 'package:cloud_tiffin/provider/new_remove_cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_models.dart';

class AddButton extends StatefulWidget {
  final CartModel? cartModel ;
 final String? price;
 final String? vendorid;
 final String? productid;
 final String? qty;
 final String? userid;
 final String? image;
 final String? totalprice;








  // price:
  // widget.cartModel!.price!,
  // productId:
  // widget.cartModel!.product_id!,
  // userid:
  // "$user_id",
  // totalprice:
  // widget.cartModel!.total_price!,
  // image: widget.cartModel!.image!,
  // vendorid:widget.cartModel!.vendor_id!,
  // qty: _counter.toString(),
  // name: widget.cartModel!.price!


  const AddButton({Key? key,this.cartModel,this.qty,this.image,this.price,this.userid,this.productid,this.totalprice,this.vendorid}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override initState(){
    super.initState();
    _get_session();
  }
  String? user_id;
  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id');
  }

  int  _counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      // cart.addQty();
                      _counter--;

                     NewRemoveCartProvider.initial(
                       productId: widget.cartModel!.product_id! ,
                       userid: user_id ,
                       vendorid: widget.cartModel!.vendor_id!,
                       qty: _counter.toString(),
                     );

                      if (_counter <= 0) {
                        _counter = 0;
                        if(_counter == 0){
                          // Navigator.pop(context);
                          // Navigator.pushNamed(context, MyRoutes.CartListPage);
                        }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.center,
                  width: 24,
                  height: 24,
                  child: kTextstyle(
                      myText: _counter.toString() , mySize: 16),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      _counter++;
                      NewCartProvider.initial(
                          price:
                          widget.cartModel!.price!,
                          productId:
                          widget.cartModel!.product_id!,
                          userid:
                          "$user_id",
                          totalprice:
                          widget.cartModel!.total_price!,
                          image: widget.cartModel!.image!,
                          vendorid:widget.cartModel!.vendor_id!,
                          qty: _counter.toString(),
                          name: widget.cartModel!.price!);
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
    );}
}
