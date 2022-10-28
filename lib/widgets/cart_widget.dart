
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../screens/new_cart_page.dart';


class AppBarActionWidgets{
  Widget cartWidget(context){
    CartController cartController=Get.put(CartController(),tag: "cart");
    print("hey ${cartController.dataList.length}");
    return  Obx((){
      if (!cartController.isError.value) { // if no any error
        if (cartController.isLoading.value) {
          return IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewCartPage(
                  ),
                ),
              );

            }, icon: Icon(Icons.shopping_cart),
          );
        }
        else if (cartController.dataList.length==0) {
          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewCartPage(
                      ),
                    ),
                  );

                }, icon: Icon(Icons.shopping_cart,),
              ),
              const Positioned
                (top: 5,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text("0",style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),),
                  ))
            ],
          );
        }
        else {
          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewCartPage(
                      ),
                    ),
                  );

                }, icon: Icon(Icons.shopping_cart),
              ),
              Positioned
                (top: 5,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text("${cartController.dataList.length}",style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    ),),
                  ))
            ],
          );
        }
      }else {
        //return Text("");
        return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewCartPage(
              ),
            ),
          );

        }, icon: Icon(Icons.shopping_cart,),
      );
      } //Error svg
    });
  }
}