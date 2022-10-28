


import 'package:get/get.dart';

import '../model/search_model.dart';

import '../service/search_service.dart';


class SearchController extends GetxController{
  var isLoading=false.obs; //Loading for data fetching
  var dataList= [].obs; //Object of blog post model
  var isError=false.obs; // Error handling
  Rx<SearchModel> newAllKitchenModel=SearchModel().obs;
  // Rx<Products> newProducts=Products().obs;
  Rx<Products> newProducts=Products().obs;
  final id;

  var price=0.obs;
  var qty=0.obs;
 
  SearchController(
      this.id
      );

  //pagination
  // ScrollController scrollController=ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    // getData(); //fetching data
    print("hey 2");
    getData(this.id);
    // getData(this.id);
    // paginateTasks();
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    // scrollController.dispose();
    super.dispose();
  }
  void getData(String id)async{
    print("hey 3");
    isLoading(true);
    //   dataList.value=[];
    try{
      print("hey 4");
      final getDataList=await SearchService.getData(id); //Get all blog post list details from the blog post service page
      print("helo yd");
      print(getDataList);
      //print(getDataList.length);
      if (getDataList!=null) dataList.value=getDataList; // If not null then store all post list details
      else isError(true); // If its error
    }
    catch(e){
      print("hey 5");
      isError(true);  // If its error
    }

    finally{
      isLoading(false); // Run try block with error ot without error
    }

  }
  void addDataModel(SearchModel newAllKitchenModel){

    this.newAllKitchenModel(newAllKitchenModel);
  }
  void addDataProductModel(price ,qty){

    this.price(price);
    this.qty(qty);
  }

  updateIsSelected(String? pIdProduct, bool? isSelected) {
    print(newProducts.runtimeType);
    // final index = newProducts.indexWhere((e) => e.id == pIdProduct);
    // if (index > -1) newProducts[index].isSelected = isSelected;
    update();
  }

  updateQty(RxList<Products> data, int pIdProduct, pQty) {
    final index = data.indexWhere((e) => e.id == pIdProduct);
    if (index > -1) data[index].isQty = pQty;
  }


}
