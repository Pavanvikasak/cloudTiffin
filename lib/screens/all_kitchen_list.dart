
import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../controllers/kitchen_controller.dart';
import '../model/NewAllKitchenModel.dart';
import '../provider/all_kitchen_provider.dart';
import 'new_kitchen_page.dart';

class AllKitchenScreen extends StatefulWidget {
  const AllKitchenScreen({Key? key}) : super(key: key);

  @override
  State<AllKitchenScreen> createState() => _AllKitchenScreenState();
}

class _AllKitchenScreenState extends State<AllKitchenScreen> {
  late KitchenController _kitchenController;
  @override initState(){
    super.initState();

    _kitchenController= Get.put(KitchenController(),tag: "kitchen");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kredColor,
        elevation: 0,
        shadowColor: kwhiteColor,
        leadingWidth: 36,
        title: kTextstyle(myText: 'All Kitchen',mySize: 18,myWeight: FontWeight.w600),

      ),
      body:SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 18

            ,),

            _handle_build_all_kitchen(),
          ],
        ),
      ),
    );


  }
  _handle_build_all_kitchen(){
    print("hello yd");
    return Container(

      child: Obx(() {
        if (!_kitchenController.isError.value) { // if no any error
          if (_kitchenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: kredColor,
              ),
            );
          } else if (_kitchenController.dataList.length== 0) {
            return Text("hello yd"); // NoDataWidget(); // No data svg
          } else {
            return _buildListView(_kitchenController.dataList);
          }
        }else {
          return Text("");
        }//IErrorWidget(); //Error svg
      }),
    );
  }
  _buildListView(newKitchenList){
    print("hello ////$newKitchenList");
   return GridView.builder(
       shrinkWrap: true,
       itemCount: newKitchenList.length,
       padding: EdgeInsets.all(0),
       physics: NeverScrollableScrollPhysics(),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (BuildContext context,index){
     NewAllKitchenModel data = newKitchenList[index];
    //NewAllKitchenModel data =services [index];

     return
       (allTimeStatus(data.breakfastOpen, data.breakfastClose, data.lunchOpen, data.lunchClose, data.dinnerOpen, data.dinnerClose) == true)?

       InkWell(
         onTap: (){
           Get.to(()=>NewKitchenPage(newallkitchenmodel: data,));
         },
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child:

           Container(height: 10,width: 10,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                 image: DecorationImage(image: NetworkImage(data.shopImage.toString()),fit: BoxFit.cover),
                 color: kwhiteColor,
                 boxShadow: [BoxShadow(
                     color: kblackcolor.withOpacity(0.12),
                     offset: Offset(0,2),
                     blurRadius: 4
                 )]),
             child: Column(mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Container(height: 42,width: double.maxFinite,
                     decoration:BoxDecoration(
                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                         gradient: LinearGradient(
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,

                           stops: [0.0, 0.4, 0.8, 1],
                           colors: [
                             Colors.black.withOpacity(0.0),
                             Colors.black.withOpacity(0.4),
                             Colors.black.withOpacity(0.6),
                             Colors.black.withOpacity(0.8),
                           ],
                         )
                     ),
                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                       children: [SizedBox(height: 6,),
                         Padding(
                           padding: const EdgeInsets.only(left: 8,top: 12),
                           child: kTextstyle(myText: data.shopName.toString(),mySize: 14,myWeight: FontWeight.w600,myColor: kwhiteColor),
                         ),
                       ],
                     ))
               ],
             ),

           ),
         ),
       ) :
        Container();
       // Padding(
       //   padding: const EdgeInsets.all(8.0),
       //   child:
       //
       //   Container(height: 10,width: 10,
       //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
       //         image: DecorationImage(image: NetworkImage(data.shopImage.toString()),colorFilter: ColorFilter.mode(kgreyColor!, BlendMode.color),fit: BoxFit.cover),
       //         color: kwhiteColor,
       //         boxShadow: [BoxShadow(
       //             color: kblackcolor.withOpacity(0.12),
       //             offset: Offset(0,2),
       //             blurRadius: 4
       //         )]),
       //     child: Column(mainAxisAlignment: MainAxisAlignment.end,
       //       children: [
       //         Transform.rotate(
       //
       //             angle: 12,
       //             child: kTextstyle(myText: "Closed Now",myColor: kwhiteColor,mySize: 14,myWeight: FontWeight.w600,space: 0.8)),
       //         SizedBox(height: 36,),
       //         Container(height: 42,width: double.maxFinite,
       //             decoration:BoxDecoration(
       //                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
       //                 gradient: LinearGradient(
       //                   begin: Alignment.topCenter,
       //                   end: Alignment.bottomCenter,
       //
       //                   stops: [0.0, 0.4, 0.8, 1],
       //                   colors: [
       //                     Colors.black.withOpacity(0.0),
       //                     Colors.black.withOpacity(0.4),
       //                     Colors.black.withOpacity(0.6),
       //                     Colors.black.withOpacity(0.8),
       //                   ],
       //                 )
       //             ),
       //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       //               children: [SizedBox(height: 6,),
       //                 Padding(
       //                   padding: const EdgeInsets.only(left: 8,top: 12),
       //                   child: kTextstyle(myText: data.shopName.toString(),mySize: 14,myWeight: FontWeight.w600,myColor: kwhiteColor),
       //                 ),
       //               ],
       //             ))
       //       ],
       //     ),
       //
       //   ),
       // ) ;

   });


  }
}