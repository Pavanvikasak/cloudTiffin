import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/model/Quick_category_model.dart';
import 'package:cloud_tiffin/provider/quick_category_provider.dart';
import 'package:cloud_tiffin/screens/kitchen_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../cards.dart';
import '../helper/colors.dart';
import '../helper/theme.dart';

class SearchKitchenList extends StatefulWidget {
  const SearchKitchenList({Key? key}) : super(key: key);

  @override
  State<SearchKitchenList> createState() => _SearchKitchenListState();
}

class _SearchKitchenListState extends State<SearchKitchenList> {
  final int _index = int.parse(Get.arguments[0]['product_id']);

  dynamic getargument = Get.arguments;
  List filter = [
    "filters",
    "All Tiffin Provider",
    "Veg",
    "Non-Veg",
    "Nearest",
    "Rating 4+"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kredColor,
        shadowColor: kwhiteColor,
        leadingWidth: 24,
        title: kTextstyle(
            myText: "${Get.arguments[1]['name']}",
            mySize: 18,
            myWeight: FontWeight.w600),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                child: Text("${Get.arguments[1]['name']}"),
              ),
              // child: ChangeNotifierProvider(
              //   create: (BuildContext context) => QuickProvider.initial(
              //       catid: Get.arguments[0]['product_id'], distance: '500'),
              //   child: Builder(builder: (context) {
              //     final model = Provider.of<QuickProvider>(context);
              //     final quicklist = model.allShopList;
              //     print("Hello ${quicklist.length}");
              //     if (quicklist.length != 0) {
              //       return (quicklist.isEmpty)
              //           ? Center(child: const CircularProgressIndicator())
              //           : ListView.builder(
              //           shrinkWrap: true,
              //           padding: EdgeInsets.zero,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemCount: quicklist.length,
              //           itemBuilder: (BuildContext context, index) {
              //             QuickCategoryModel quickcategory =
              //             quicklist[index];
              //             var open = [
              //               quickcategory.lunchOpen,
              //               quickcategory.lunchOpen,
              //               quickcategory.dinnerOpen,
              //               quickcategory.breakfastOpen,
              //               quickcategory.openingTime
              //             ];
              //             var close = [
              //               quickcategory.lunchClose,
              //               quickcategory.lunchClose,
              //               quickcategory.dinnerClose,
              //               quickcategory.breakfastClose,
              //               quickcategory.clossingTime
              //             ];
              //             return (quickcategory.products!.isEmpty ||
              //                 quickcategory.products == null)
              //                 ? Container()
              //                 : (checkAvailable(
              //                 open[_index], close[_index]) ==
              //                 false)
              //                 ? InkWell(
              //               onTap: () {
              //                 Get.to(
              //                       () => KitchenPage(
              //                     quickCategoryModel:
              //                     quickcategory,
              //                   ),
              //                 );
              //               },
              //               child: Padding(
              //                 padding:
              //                 const EdgeInsets.only(top: 6),
              //                 child: QuickSellerCard(
              //                     odelivery: quickcategory
              //                         .deliveryTime
              //                         .toString(),
              //                     time: quickcategory.openingTime
              //                         .toString() +
              //                         ' - ' +
              //                         quickcategory.clossingTime
              //                             .toString(),
              //                     oimage: quickcategory.shopImage
              //                         .toString(),
              //                     oname: quickcategory.shopName
              //                         .toString(),
              //                     onavi: '',
              //                     distance: quickcategory
              //                         .distance!
              //                         .substring(0, 3)),
              //               ),
              //             )
              //                 : Padding(
              //               padding:
              //               const EdgeInsets.only(top: 6),
              //               child: GreyQuickSellerCard(
              //                   odelivery: quickcategory
              //                       .deliveryTime
              //                       .toString(),
              //                   time: quickcategory.openingTime
              //                       .toString() +
              //                       ' - ' +
              //                       quickcategory.clossingTime
              //                           .toString(),
              //                   oimage: quickcategory.shopImage
              //                       .toString(),
              //                   oname: quickcategory.shopName
              //                       .toString(),
              //                   onavi: '',
              //                   distance: quickcategory.distance!
              //                       .substring(0, 3)),
              //             );
              //           });
              //     } else {
              //       return Padding(
              //         padding:
              //         EdgeInsets.only(top: screen.heigth(context) * 0.3),
              //         child: Center(
              //             child: kTextstyle(
              //                 myText: "No Product Found",
              //                 mySize: 16,
              //                 myWeight: FontWeight.w600,
              //                 myColor: kgreyColor)),
              //       );
              //     }
              //   }),
              // ),
            ),
            // Text('data',style: TextStyle(letterSpacing: ),)
          ],
        ),
      ),
    );
  }
}