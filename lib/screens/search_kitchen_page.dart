
import 'package:cloud_tiffin/widgets/kitchenadd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/search_controller.dart';
import '../helper/colors.dart';

import '../helper/screen_size.dart';
import '../helper/theme.dart';

// import '../provider/new_cart_provider.dart';
import 'package:cloud_tiffin/global.dart' as globals;

import '../model/search_model.dart';
import 'new_cart_page.dart';

class SearchKitchenPage extends StatefulWidget {



 // const SearchKitchenPage({Key? key,this.newSearchModel}) : super(key: key);
 SearchKitchenPage({Key? key}) : super(key: key);

  @override
  State<SearchKitchenPage> createState() => _SearchKitchenPageState();
}

class _SearchKitchenPageState extends State<SearchKitchenPage> {
  bool isVisible = false;
  dynamic argumentData = Get.arguments;
  dynamic getarguments = Get.arguments;

  final String name = "kavita's Tiffin services";
  // final String description =
  //     "veg, Snack, South indian, North indian, Fast food";
  final String open = "7 am - 8 pm";
  final String id = "01";
  final String image = "assets/images/kit1.jpg";
  String? user_id;
  String? globalid;
  String? vendor_id;
  late SearchController _searchController;
  SearchModel? newKitchenList;
  bool isFav = false;
  List<Map<String, String>> Totalitem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vendor_id=   Get.arguments[0]['vendor_id'];
    });
   // print("hello ${widget.mainDataList!.shopName!}");
    _searchController= Get.put(SearchController(vendor_id),tag: "search_kitchen");
    _get_session();
    setState(() {
      globalid = globals.isVendorSelectedId;
      print("helllo global id $globalid");
      print("helllo global id ${globals.isVendorSelected}");
    });
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<NewCartProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _handle_build_kitchen(),
          // Container(
          //     alignment: Alignment.bottomCenter,
          //     width: screen.width(context),
          //     height: screen.heigth(context),
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: NetworkImage(
          //                 widget.newSearchModel!.shopImage.toString()),
          //             fit: BoxFit.cover)),
          //     child: SingleChildScrollView(
          //       child: Padding(
          //         padding: EdgeInsets.only(top: size.height * 0.46),
          //         child: Container(
          //           width: screen.width(context),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: kblackcolor.withOpacity(0.2),
          //                     blurRadius: 8,
          //                     offset: const Offset(0, -8))
          //               ],
          //               borderRadius: const BorderRadius.only(
          //                 topRight: Radius.circular(28),
          //                 topLeft: Radius.circular(28),
          //               )),
          //           child: Padding(
          //             padding: const EdgeInsets.all(16),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //                 kTextstyle(
          //                     mySize: 20,
          //                     myText: widget.newSearchModel!.shopName
          //                         .toString(),
          //                     myWeight: FontWeight.w700),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //                 kTextstyle(
          //                     mySize: 14,
          //                     myText: description,
          //                     lines: 4,
          //                     myWeight: FontWeight.w500,
          //                     myColor: Colors.grey),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //
          //                 kTextstyle(
          //                     mySize: 14,
          //                     myText: "Open on",
          //                     myWeight: FontWeight.w600,
          //                     myColor: Colors.green),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //
          //                 const SizedBox(
          //                   height: 4,
          //                 ),
          //
          //                 const SizedBox(
          //                   width: 16,
          //                 ),
          //
          //                 //partition grey
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 8),
          //                   child: Container(
          //                     height: 2,
          //                     width: double.maxFinite,
          //                     color: Colors.grey.withOpacity(0.08),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(16),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                     children: [
          //                       Column(
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Icon(Icons.star_border,
          //                                   color: kgreenColor, size: 16),
          //                               const SizedBox(
          //                                 width: 4,
          //                               ),
          //                               kTextstyle(
          //                                   myText: '4',
          //                                   mySize: 18,
          //                                   myColor: kgreenColor)
          //                             ],
          //                           ),
          //                           const SizedBox(
          //                             height: 4,
          //                           ),
          //                           kTextstyle(
          //                               myText: "Rating",
          //                               mySize: 14,
          //                               myWeight: FontWeight.w500)
          //                         ],
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             horizontal: 16),
          //                         child: Container(
          //                           height: 42,
          //                           width: 2,
          //                           color: kredColor.withOpacity(0.08),
          //                         ),
          //                       ),
          //                       Column(
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Icon(FontAwesome.clock_o,
          //                                   color: kgreenColor, size: 16),
          //                               const SizedBox(
          //                                 width: 8,
          //                               ),
          //                               kTextstyle(
          //                                   myText:
          //                                   '${widget.newSearchModel!.deliveryTime} min',
          //                                   mySize: 16,
          //                                   myColor: kgreenColor)
          //                             ],
          //                           ),
          //                           const SizedBox(
          //                             height: 6,
          //                           ),
          //                           kTextstyle(
          //                               myText: "Delivery Time",
          //                               mySize: 14,
          //                               myWeight: FontWeight.w500)
          //                         ],
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             horizontal: 16),
          //                         child: Container(
          //                           height: 42,
          //                           width: 2,
          //                           color: kredColor.withOpacity(0.08),
          //                         ),
          //                       ),
          //                       Column(
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Icon(
          //                                 Icons.thumb_up,
          //                                 color: kgreenColor,
          //                                 size: 14,
          //                               ),
          //                               const SizedBox(
          //                                 width: 4,
          //                               ),
          //                               kTextstyle(
          //                                   myText: '4',
          //                                   mySize: 18,
          //                                   myColor: kgreenColor)
          //                             ],
          //                           ),
          //                           const SizedBox(
          //                             height: 4,
          //                           ),
          //                           kTextstyle(
          //                               myText: "Reviews",
          //                               mySize: 14,
          //                               myWeight: FontWeight.w500)
          //                         ],
          //                       ),
          //
          //                       // Padding(
          //                       //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //                       //   child: Container(height: 42,
          //                       //     width: 2,
          //                       //     color: kgreenColor,),
          //                       // )
          //                     ],
          //                   ),
          //                 ),
          //
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 0),
          //                   child: Container(
          //                     height: 2,
          //                     width: double.maxFinite,
          //                     color: Colors.grey.withOpacity(0.08),
          //                   ),
          //                 ),
          //                 kSizedBox1,
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 0),
          //                   child: kTextstyle(
          //                       myText: "Today's  Menu",
          //                       mySize: 16,
          //                       myWeight: FontWeight.w700),
          //                 ),
          //                 // Text('data',style: TextStyle(wordSpacing: ),)
          //                 if (widget.newSearchModel!.products!.isEmpty)
          //                   Padding(
          //                     padding: EdgeInsets.only(
          //                         top: 12, left: screen.width(context) * 0.2),
          //                     child: kTextstyle(
          //                         myText: 'Sorry we are out of service now',
          //                         space: 0.6,
          //                         myWeight: FontWeight.w600,
          //                         myColor: kgreyColor),
          //                   )
          //                 else
          //                   ListView.builder(
          //                       shrinkWrap: true,
          //                       itemCount: 1,
          //                       padding: const EdgeInsets.only(top: 12),
          //                       physics: const NeverScrollableScrollPhysics(),
          //                       itemBuilder: (BuildContext context, index) {
          //                         return Column(
          //                           crossAxisAlignment:
          //                           CrossAxisAlignment.start,
          //                           children: [
          //
          //                             Padding(
          //                               padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
          //                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Container(
          //                                         height: 28,
          //                                         width: 28,
          //                                         decoration: BoxDecoration(
          //                                             borderRadius:
          //                                             BorderRadius.circular(12),
          //                                             image: const DecorationImage(
          //                                               image: const AssetImage(
          //                                                   'assets/images/sunrise.png'),
          //                                             )),
          //                                       ),
          //                                       const SizedBox(
          //                                         width: 12,
          //                                       ),
          //                                       kTextstyle(
          //                                           myText:
          //                                           "Breakfast            ",
          //                                           mySize: 16,space: 0.8,
          //                                           myWeight: FontWeight.w600,
          //                                           myColor: kgreyColor),
          //                                     ],
          //                                   ),
          //                                   kTextstyle(
          //                                       mySize: 12,
          //                                       myText: widget.newSearchModel!
          //                                           .breakfastOpen
          //                                           .toString() +
          //                                           "  - " +
          //                                           widget.newSearchModel!
          //                                               .breakfastClose
          //                                               .toString(),
          //                                       myWeight: FontWeight.w600),
          //                                 ],
          //                               ),
          //                             ),
          //
          //                             product(3.toString(),widget.newSearchModel!.breakfastOpen,widget.newSearchModel!.breakfastClose),
          //
          //                             Padding(
          //                               padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
          //                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Container(
          //                                         height: 28,
          //                                         width: 28,
          //                                         decoration: BoxDecoration(
          //                                             borderRadius:
          //                                             BorderRadius.circular(12),
          //                                             image: const DecorationImage(
          //                                               image: const AssetImage(
          //                                                   'assets/images/sunny.png'),
          //                                             )),
          //                                       ),
          //                                       const SizedBox(
          //                                         width: 12,
          //                                       ),
          //                                       kTextstyle(
          //                                           myText:
          //                                           "Lunch            ",
          //                                           mySize: 16,space: 0.8,
          //                                           myWeight: FontWeight.w600,
          //                                           myColor: kgreyColor),
          //                                     ],
          //                                   ),
          //                                   kTextstyle(
          //                                       mySize: 12,
          //                                       myText: widget.newSearchModel!
          //                                           .lunchOpen
          //                                           .toString() +
          //                                           "  - " +
          //                                           widget.newSearchModel!
          //                                               .lunchClose
          //                                               .toString(),
          //                                       myWeight: FontWeight.w600),
          //                                 ],
          //                               ),
          //                             ),
          //                             product(1.toString(),widget.newSearchModel!.lunchOpen,widget.newSearchModel!.lunchClose!),
          //
          //
          //                             Padding(
          //                               padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
          //                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Container(
          //                                         height: 28,
          //                                         width: 28,
          //                                         decoration: BoxDecoration(
          //                                             borderRadius:
          //                                             BorderRadius.circular(12),
          //                                             image: const DecorationImage(
          //                                               image: const AssetImage(
          //                                                   'assets/images/moon.png'),
          //                                             )),
          //                                       ),
          //                                       const SizedBox(
          //                                         width: 12,
          //                                       ),
          //                                       kTextstyle(
          //                                           myText:
          //                                           "Dinner           ",
          //                                           mySize: 16,space: 0.8,
          //                                           myWeight: FontWeight.w600,
          //                                           myColor: kgreyColor),
          //                                     ],
          //                                   ),
          //                                   kTextstyle(
          //                                       mySize: 12,
          //                                       myText: widget.newSearchModel!
          //                                           .dinnerOpen
          //                                           .toString() +
          //                                           "  - " +
          //                                           widget.newSearchModel!
          //                                               .dinnerClose
          //                                               .toString(),
          //                                       myWeight: FontWeight.w600),
          //                                 ],
          //                               ),
          //                             ),
          //                             product(2.toString(),widget.newSearchModel!.dinnerOpen,widget.newSearchModel!.dinnerClose),
          //
          //                             Padding(
          //                               padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
          //                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Container(
          //                                         height: 28,
          //                                         width: 28,
          //                                         decoration: BoxDecoration(
          //                                             borderRadius:
          //                                             BorderRadius.circular(12),
          //                                             image: const DecorationImage(
          //                                               image: const AssetImage(
          //                                                   'assets/images/sunny.png'),
          //                                             )),
          //                                       ),
          //                                       const SizedBox(
          //                                         width: 12,
          //                                       ),
          //                                       kTextstyle(
          //                                           myText:
          //                                           "Constant Food            ",
          //                                           mySize: 16,space: 0.8,
          //                                           myWeight: FontWeight.w600,
          //                                           myColor: kgreyColor),
          //                                     ],
          //                                   ),
          //                                   kTextstyle(
          //                                       mySize: 12,
          //                                       myText: widget.newSearchModel!
          //                                           .openingTime
          //                                           .toString() +
          //                                           "  - " +
          //                                           widget.newSearchModel!
          //                                               .clossingTime
          //                                               .toString(),
          //                                       myWeight: FontWeight.w600),
          //                                 ],
          //                               ),
          //                             ),
          //                             product(4.toString(),widget.newSearchModel!.openingTime,widget.newSearchModel!.clossingTime),
          //                           ],
          //                         );
          //                       }),
          //                 const SizedBox(
          //                   height: 56,
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   // child:
          // ),

          /// appbar
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.01, left: 16),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

      ///bottom sheet

      bottomSheet: InkWell(
        onTap: () {
          Get.to(() => const NewCartPage());
          //Get.to(() =>CartListPage());
        },
        child: Container(
            width: screen.width(context),
            height: 48,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: kblackcolor.withOpacity(0.12),
                  offset: const Offset(0, 0),
                  blurRadius: 4)
            ], color: kgreenColor, borderRadius: BorderRadius.circular(0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    kTextstyle(
                        myText: 'View Cart',
                        myWeight: FontWeight.w600,
                        mySize: 16,
                        myColor: kwhiteColor),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.shopping_cart,
                        color: kwhiteColor,
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
  _handle_build_kitchen(){
    print("hello yd");
    return Container(

      child: Obx(() {
        if (!_searchController.isError.value) { // if no any error
          if (_searchController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: kredColor,
              ),
            );
          } else if (_searchController.dataList.length== 0) {
            return Text("hello yd"); // NoDataWidget(); // No data svg
          } else {

            return _buildView(_searchController.dataList);
          }
        }else {
          return Text("");
        }//IErrorWidget(); //Error svg
      }),
    );
  }
  _buildView(newKitchenList){
    var size = MediaQuery.of(context).size;
    print("hello search////${newKitchenList.length}");
   // print("hello search////${newKitchenList.shopImage}");

 return    ListView.builder(
     itemCount: newKitchenList.length,
     shrinkWrap: true,


     physics: const ScrollPhysics(),
     itemBuilder: (BuildContext context, index) {
       SearchModel food = newKitchenList[index];

       print(food.breakfastClose);
       return Padding(
         padding: const EdgeInsets.only(right: 8),
         child: Container(
           width: screen.width(context) * .220,
           // height: 124,
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(4),
               boxShadow: [
                 BoxShadow(
                     color:
                     kblackcolor.withOpacity(0.1),
                     blurRadius: 2,
                     offset: Offset(0, 2))
               ]),
           child: Container(
               alignment: Alignment.bottomCenter,
               width: screen.width(context),
               height: screen.heigth(context),
               decoration: BoxDecoration(
                   image: DecorationImage(
                       image: NetworkImage(
                           food.shopImage.toString()),
                       fit: BoxFit.cover)),
               child: SingleChildScrollView(
                 child: Padding(
                   padding: EdgeInsets.only(top: size.height * 0.46),
                   child: Container(
                     width: screen.width(context),
                     decoration: BoxDecoration(
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                               color: kblackcolor.withOpacity(0.2),
                               blurRadius: 8,
                               offset: const Offset(0, -8))
                         ],
                         borderRadius: const BorderRadius.only(
                           topRight: Radius.circular(28),
                           topLeft: Radius.circular(28),
                         )),
                     child: Padding(
                       padding: const EdgeInsets.all(16),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(
                             height: 8,
                           ),
                           kTextstyle(
                               mySize: 20,
                               myText: food.shopName
                                   .toString(),
                               myWeight: FontWeight.w700),
                           const SizedBox(
                             height: 8,
                           ),
                           kTextstyle(
                               mySize: 14,
                               myText: food.description.toString(),
                               lines: 4,
                               myWeight: FontWeight.w500,
                               myColor: Colors.grey),
                           const SizedBox(
                             height: 8,
                           ),

                          //  kTextstyle(
                          //      mySize: 14,
                          //      myText: "Open on",
                          //      myWeight: FontWeight.w600,
                          //      myColor: Colors.green),
                           const SizedBox(
                             height: 8,
                           ),

                           const SizedBox(
                             height: 4,
                           ),

                           const SizedBox(
                             width: 16,
                           ),

                           //partition grey
                           Padding(
                             padding: const EdgeInsets.only(top: 8),
                             child: Container(
                               height: 2,
                               width: double.maxFinite,
                               color: Colors.grey.withOpacity(0.08),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(16),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Column(
                                   children: [
                                     Row(
                                       children: [
                                         Icon(Icons.star_border,
                                             color: kgreenColor, size: 16),
                                         const SizedBox(
                                           width: 4,
                                         ),
                                         kTextstyle(
                                             myText: '4',
                                             mySize: 18,
                                             myColor: kgreenColor)
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 4,
                                     ),
                                     kTextstyle(
                                         myText: "Rating",
                                         mySize: 14,
                                         myWeight: FontWeight.w500)
                                   ],
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(
                                       horizontal: 16),
                                   child: Container(
                                     height: 42,
                                     width: 2,
                                     color: kredColor.withOpacity(0.08),
                                   ),
                                 ),
                                 Column(
                                   children: [
                                     Row(
                                       children: [
                                         Icon(FontAwesome.clock_o,
                                             color: kgreenColor, size: 16),
                                         const SizedBox(
                                           width: 8,
                                         ),
                                         kTextstyle(
                                             myText:
                                             '${food.deliveryTime} min',
                                             mySize: 16,
                                             myColor: kgreenColor)
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 6,
                                     ),
                                     kTextstyle(
                                         myText: "Delivery Time",
                                         mySize: 14,
                                         myWeight: FontWeight.w500)
                                   ],
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(
                                       horizontal: 16),
                                   child: Container(
                                     height: 42,
                                     width: 2,
                                     color: kredColor.withOpacity(0.08),
                                   ),
                                 ),
                                 Column(
                                   children: [
                                     Row(
                                       children: [
                                         Icon(
                                           Icons.thumb_up,
                                           color: kgreenColor,
                                           size: 14,
                                         ),
                                         const SizedBox(
                                           width: 4,
                                         ),
                                         kTextstyle(
                                             myText: '4',
                                             mySize: 18,
                                             myColor: kgreenColor)
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 4,
                                     ),
                                     kTextstyle(
                                         myText: "Reviews",
                                         mySize: 14,
                                         myWeight: FontWeight.w500)
                                   ],
                                 ),

                                 // Padding(
                                 //   padding: const EdgeInsets.symmetric(horizontal: 16),
                                 //   child: Container(height: 42,
                                 //     width: 2,
                                 //     color: kgreenColor,),
                                 // )
                               ],
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.only(top: 0),
                             child: Container(
                               height: 2,
                               width: double.maxFinite,
                               color: Colors.grey.withOpacity(0.08),
                             ),
                           ),
                           kSizedBox1,
                           Padding(
                             padding: const EdgeInsets.only(left: 0),
                             child: kTextstyle(
                                 myText: "Today's  Menu",
                                 mySize: 16,
                                 myWeight: FontWeight.w700),
                           ),

                           if (food.products!.isEmpty)
                             Padding(
                               padding: EdgeInsets.only(
                                   top: 12, left: screen.width(context) * 0.2),
                               child: kTextstyle(
                                   myText: 'Sorry we are out of service now',
                                   space: 0.6,
                                   myWeight: FontWeight.w600,
                                   myColor: kgreyColor),
                             )
                           else
                             ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: 1,
                                 padding: const EdgeInsets.only(top: 12),
                                 physics: const NeverScrollableScrollPhysics(),
                                 itemBuilder: (BuildContext context, index) {
                                   // return Column(
                                   //   crossAxisAlignment:
                                   //   CrossAxisAlignment.start,
                                   //   children: [
                                   //
                                   //     Padding(
                                   //       padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                   //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   //         children: [
                                   //           Row(
                                   //             children: [
                                   //               Container(
                                   //                 height: 28,
                                   //                 width: 28,
                                   //                 decoration: BoxDecoration(
                                   //                     borderRadius:
                                   //                     BorderRadius.circular(12),
                                   //                     image: const DecorationImage(
                                   //                       image: const AssetImage(
                                   //                           'assets/images/sunrise.png'),
                                   //                     )),
                                   //               ),
                                   //               const SizedBox(
                                   //                 width: 12,
                                   //               ),
                                   //               kTextstyle(
                                   //                   myText:
                                   //                   "Breakfast            ",
                                   //                   mySize: 16,space: 0.8,
                                   //                   myWeight: FontWeight.w600,
                                   //                   myColor: kgreyColor),
                                   //             ],
                                   //           ),
                                   //           kTextstyle(
                                   //               mySize: 12,
                                   //               myText: food
                                   //                   .breakfastOpen
                                   //                   .toString() +
                                   //                   "  - " +
                                   //                   food
                                   //                       .breakfastClose
                                   //                       .toString(),
                                   //               myWeight: FontWeight.w600),
                                   //         ],
                                   //       ),
                                   //     ),
                                   //
                                   //     product(food,3.toString(),food.breakfastOpen,food.breakfastClose),
                                   //
                                   //     Padding(
                                   //       padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                   //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   //         children: [
                                   //           Row(
                                   //             children: [
                                   //               Container(
                                   //                 height: 28,
                                   //                 width: 28,
                                   //                 decoration: BoxDecoration(
                                   //                     borderRadius:
                                   //                     BorderRadius.circular(12),
                                   //                     image: const DecorationImage(
                                   //                       image: const AssetImage(
                                   //                           'assets/images/sunny.png'),
                                   //                     )),
                                   //               ),
                                   //               const SizedBox(
                                   //                 width: 12,
                                   //               ),
                                   //               kTextstyle(
                                   //                   myText:
                                   //                   "Lunch            ",
                                   //                   mySize: 16,space: 0.8,
                                   //                   myWeight: FontWeight.w600,
                                   //                   myColor: kgreyColor),
                                   //             ],
                                   //           ),
                                   //           kTextstyle(
                                   //               mySize: 12,
                                   //               myText: food
                                   //                   .lunchOpen
                                   //                   .toString() +
                                   //                   "  - " +
                                   //                   food
                                   //                       .lunchClose
                                   //                       .toString(),
                                   //               myWeight: FontWeight.w600),
                                   //         ],
                                   //       ),
                                   //     ),
                                   //     product(food,1.toString(),food.lunchOpen,food.lunchClose!),
                                   //
                                   //
                                   //     Padding(
                                   //       padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                   //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   //         children: [
                                   //           Row(
                                   //             children: [
                                   //               Container(
                                   //                 height: 28,
                                   //                 width: 28,
                                   //                 decoration: BoxDecoration(
                                   //                     borderRadius:
                                   //                     BorderRadius.circular(12),
                                   //                     image: const DecorationImage(
                                   //                       image: const AssetImage(
                                   //                           'assets/images/moon.png'),
                                   //                     )),
                                   //               ),
                                   //               const SizedBox(
                                   //                 width: 12,
                                   //               ),
                                   //               kTextstyle(
                                   //                   myText:
                                   //                   "Dinner           ",
                                   //                   mySize: 16,space: 0.8,
                                   //                   myWeight: FontWeight.w600,
                                   //                   myColor: kgreyColor),
                                   //             ],
                                   //           ),
                                   //           kTextstyle(
                                   //               mySize: 12,
                                   //               myText: food
                                   //                   .dinnerOpen
                                   //                   .toString() +
                                   //                   "  - " +
                                   //                   food
                                   //                       .dinnerClose
                                   //                       .toString(),
                                   //               myWeight: FontWeight.w600),
                                   //         ],
                                   //       ),
                                   //     ),
                                   //     product(food,2.toString(),food.dinnerOpen,food.dinnerClose),
                                   //
                                   //     Padding(
                                   //       padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                   //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   //         children: [
                                   //           Row(
                                   //             children: [
                                   //               Container(
                                   //                 height: 28,
                                   //                 width: 28,
                                   //                 decoration: BoxDecoration(
                                   //                     borderRadius:
                                   //                     BorderRadius.circular(12),
                                   //                     image: const DecorationImage(
                                   //                       image: const AssetImage(
                                   //                           'assets/images/sunny.png'),
                                   //                     )),
                                   //               ),
                                   //               const SizedBox(
                                   //                 width: 12,
                                   //               ),
                                   //               kTextstyle(
                                   //                   myText:
                                   //                   "Constant Food            ",
                                   //                   mySize: 16,space: 0.8,
                                   //                   myWeight: FontWeight.w600,
                                   //                   myColor: kgreyColor),
                                   //             ],
                                   //           ),
                                   //           kTextstyle(
                                   //               mySize: 12,
                                   //               myText: food
                                   //                   .openingTime
                                   //                   .toString() +
                                   //                   "  - " +
                                   //                   food
                                   //                       .clossingTime
                                   //                       .toString(),
                                   //               myWeight: FontWeight.w600),
                                   //         ],
                                   //       ),
                                   //     ),
                                   //     product(food,4.toString(),food.openingTime,food.clossingTime),
                                   //   ],
                                   // );
                                 return  category_time(food);
                                 }),
                           const SizedBox(
                             height: 56,
                           )
                         ],
                       ),
                     ),
                   ),
                 ),
               )
             // child:
           ),
         ),
       );
     });


  }

  category_time(food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        checkAvailable(food.breakfastOpen, food.breakfastClose)?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage("assets/images/sunrise.png"),
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      kTextstyle(
                          myText: "Breakfast",
                          mySize: 16,
                          space: 0.8,
                          myWeight: FontWeight.w600,
                          myColor: kgreyColor),
                    ],
                  ),
                  kTextstyle(
                      mySize: 12,
                      myText: food.breakfastOpen!
                          .toString() +
                          "  - " +
                          food.breakfastClose!.toString(),
                      myWeight: FontWeight.w600),
                ],
              ),
            ),
            product(food,3.toString(), food.breakfastOpen,
                food.breakfastClose),
          ],
        ):Container(),
        checkAvailable(food.lunchOpen, food.lunchClose)?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image:
                              const AssetImage('assets/images/sunny.png'),
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      kTextstyle(
                          myText: "Lunch            ",
                          mySize: 16,
                          space: 0.8,
                          myWeight: FontWeight.w600,
                          myColor: kgreyColor),
                    ],
                  ),
                  kTextstyle(
                      mySize: 12,
                      myText: food.lunchOpen.toString() +
                          "  - " +
                          food.lunchClose.toString(),
                      myWeight: FontWeight.w600),
                ],
              ),
            ),
            product(food,1.toString(), food.lunchOpen,
                food.lunchClose!),
          ],
        ):Container(),
        checkAvailable(food.dinnerOpen, food.dinnerClose)?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: const AssetImage('assets/images/moon.png'),
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      kTextstyle(
                          myText: "Dinner           ",
                          mySize: 16,
                          space: 0.8,
                          myWeight: FontWeight.w600,
                          myColor: kgreyColor),
                    ],
                  ),
                  kTextstyle(
                      mySize: 12,
                      myText: food.dinnerOpen.toString() +
                          "  - " +
                          food.dinnerClose.toString(),
                      myWeight: FontWeight.w600),
                ],
              ),
            ),
            product(food,2.toString(), food.dinnerOpen,
                food.dinnerClose),
          ],
        ):Container(),
        checkAvailable(food.openingTime,food.clossingTime)?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image:
                              const AssetImage('assets/images/sunny.png'),
                            )),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      kTextstyle(
                          myText: "Constant Food            ",
                          mySize: 16,
                          space: 0.8,
                          myWeight: FontWeight.w600,
                          myColor: kgreyColor),
                    ],
                  ),
                  kTextstyle(
                      mySize: 12,
                      myText: food.openingTime
                          .toString() +
                          "  - " +
                          food.clossingTime.toString(),
                      myWeight: FontWeight.w600),
                ],
              ),
            ),
            product(food,4.toString(), food.openingTime,
                food.clossingTime),
          ],
        ):Container(),
      ],
    );
  }
  product(food,String? _id, opentime ,closetime) {
    bool check =  checkAvailable(opentime, closetime);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: food!.products!.length,
      itemBuilder: (BuildContext context, product) {
        SearchModel all = food!;
        var data = all.products!;
        return (data[product].categoryId == _id)
            ?
        (data[product].leftqty != "0" ||data[product].leftqty == null ) ?Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: check? Colors.white:Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color:check? Colors.transparent : Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 6,
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            kTextstyle(
                                mySize: 16,
                                space: 0.7,
                                myText: data[product].name.toString(),lines: 2,myColor: check? kblackcolor:kgreyColor!.withOpacity(0.8),
                                myWeight: FontWeight.w600),
                            kTextstyle(myText: "Qty left : ${data[product].leftqty}",mySize: 12,myColor: check? kblackcolor:kgreyColor!.withOpacity(0.8),
                                myWeight: FontWeight.w600),
                            // kTextstyle(
                            //     mySize: 12,
                            //     myText:
                            //         data[product]
                            //             .categoryId
                            //             .toString(),
                            //     myColor:
                            //         Colors.grey),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee_outlined,
                                  size: 18,

                                ),
                                kTextstyle(
                                    mySize: 18,
                                    myColor: check? kblackcolor:kgreyColor!.withOpacity(0.8),
                                    myText: data[product].price.toString(),
                                    myWeight: FontWeight.w600),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            kTextstyle(
                                mySize: 13,
                                myColor: check? kblackcolor:kgreyColor!.withOpacity(0.8),
                                myText: data[product].description.toString(),
                                lines: 3),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12),
                        child: Container(
                          width: 96,
                          height: 74,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border:
                              Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                    color: check? kredColor.withOpacity(0.2):Colors.grey.shade400,
                                    blurRadius: 6)
                              ],

                              /// networkimage
                              image: DecorationImage(
                                  image: NetworkImage(
                                      data[product].thumbnail.toString()),colorFilter: ColorFilter.mode(check? Colors.transparent:kgreyColor!.withOpacity(0.3), BlendMode.multiply),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),

                      ///=================================================================,
                      ///=================================================================,
                      ///===== Add counter===================================================
                      ///=================================================================
                      // setState(() {globals.isVendorSelectedId++;});
                      // print(globals.isVendorSelectedId);
                      check == true? KitchenAddButton(
                        // index: product.toString(),
                        name: data[product].name!,
                        vendorid: data[product].vendorId,
                        userid: "$user_id",
                        productid: data[product].id,
                        price: data[product].price,
                        qty: '1',
                        image: data[product].thumbnail,
                        totalprice: data[product].price,
                        globalid: data[product].vendorId,
                        //isSelected: data[product].isSelected,
                        isQty: data[product].isQty,
                      ): Padding(
                        padding: const EdgeInsets.only(right: 16,top: 6,bottom: 4),
                        child: kTextstyle(myText: "Not Available for now",myColor: kredColor,myWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ))
            : Container():Container();
      },
    );
  }
}

showDataAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: const Text(
            "Create ID",
            style: const TextStyle(fontSize: 24.0),
          ),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: const Text(
                      "Mension Your ID ",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Id here',
                          labelText: 'ID'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Submit",
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Note'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                          ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                          ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                          ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                          'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                          ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

class PopupCard extends StatefulWidget {
  final selectedService;

  PopupCard({Key? key, required this.selectedService}) : super(key: key);

  @override
  State<PopupCard> createState() => _PopupcardState();
}

class _PopupcardState extends State<PopupCard> {
  @override
  Widget build(BuildContext context) {
    return (widget.selectedService != null)
        ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Container(
          width: screen.width(context),
          height: 56,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: kblackcolor.withOpacity(0.24),
                offset: const Offset(0, 4),
                blurRadius: 4)
          ], color: kgreenColor, borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: kTextstyle(
                        myText:
                        widget.selectedService.toString() + '  items',
                        mySize: 16,
                        myWeight: FontWeight.w600,
                        myColor: kwhiteColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Container(
                      width: 2,
                      height: 36,
                      color: kwhiteColor,
                    ),
                  ),
                  Icon(
                    Icons.currency_rupee,
                    size: 20,
                    color: kwhiteColor,
                  ),
                  kTextstyle(
                      myText: '225.00',
                      mySize: 20,
                      myColor: kwhiteColor,
                      myWeight: FontWeight.w600)
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {});
                  // Get.to(() => CartListPage());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Row(
                    children: [
                      kTextstyle(
                          myText: 'View Cart',
                          myWeight: FontWeight.w600,
                          mySize: 16,
                          myColor: kwhiteColor),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.shopping_cart,
                          color: kwhiteColor,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    )
        : Container();
  }
}
