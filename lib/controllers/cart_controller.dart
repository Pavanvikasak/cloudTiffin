

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/cart_service.dart';


class CartController extends GetxController{
  var isLoading=false.obs; //Loading for data fetching
  var dataList= [].obs; //Object of blog post model
  var isError=false.obs; // Error handling
  // var perPage=10;
  // var isMoreData=true.obs;
  // var isPaginationLoading=false.obs;
  // var isPaginationError=false.obs;
  CartController();
  //pagination
  // ScrollController scrollController=ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    // getData(); //fetching data
    print("hey 2");
    getData();
    // paginateTasks();
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    // scrollController.dispose();
    super.dispose();
  }
  void getData()async{
    print("hey 3");
    isLoading(true);
    //   dataList.value=[];
    try{
      print("hey 4");
      final getDataList= await CartService.getData(); //Get all blog post list details from the blog post service page
      // print("helo yd cart");
      // print(getDataList.length);
      //print(getDataList.length);
      if (getDataList!=null) {
        //isError(false);
        print("/////////////////////////");
        print(getDataList.length);
        dataList.value = getDataList;

      } // If not null then store all post list details
      else {
        isError(true);
      }// If its error
    }
    catch(e){
      print("hey 5");
      isError(true);  // If its error
    }

    finally{
      isLoading(false); // Run try block with error ot without error
    }

  }


}
