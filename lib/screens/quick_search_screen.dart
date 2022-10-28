import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/model/Quick_category_model.dart';
import 'package:cloud_tiffin/provider/quick_category_provider.dart';
import 'package:cloud_tiffin/screens/kitchen_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cards.dart';
import '../helper/colors.dart';
import '../helper/theme.dart';

class QuickSearchScreen extends StatefulWidget {
  const QuickSearchScreen({Key? key}) : super(key: key);

  @override
  State<QuickSearchScreen> createState() => _QuickSearchScreenState();
}

class _QuickSearchScreenState extends State<QuickSearchScreen> {
  final int _index = int.parse(Get.arguments[0]['cat_id']);
  bool inDistance = false;
  final Distance distance = const Distance();
  dynamic getargument = Get.arguments;
  String? cat_name;
  List filter = [
    "filters",
    "All Tiffin Provider",
    "Veg",
    "Non-Veg",
    "Nearest",
    "Rating 4+"
  ];
  @override initState(){
    super.initState();
    setState(() {
      cat_name =  Get.arguments[1]['name'];
    });

  }
  distanceCalculator(double lat2, double long2, double Distance) async {
    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();
    double lat1 = double.parse(latitude);
    double long1 = double.parse(longitude);
    final double km = distance.as(LengthUnit.Kilometer, LatLng(lat1, long1), LatLng(lat2, long2));
    print("$km // $Distance");
    if (km < Distance) {
      print(true);
      setState(() {
        inDistance = true;
      });
      return inDistance;
    } else {
      setState(() {
        inDistance = false;
      });
      print(false);
      return inDistance;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kredColor,
        shadowColor: kwhiteColor,
       // leadingWidth: 24,
        title: kTextstyle(
            myText: "${cat_name}",
            mySize: 18,
            myWeight: FontWeight.w600),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kwhiteColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ChangeNotifierProvider(
                create: (BuildContext context) => QuickProvider.initial(
                    catid: Get.arguments[0]['cat_id'], distance: '10'),
                child: Builder(builder: (context) {
                  final model = Provider.of<QuickProvider>(context);
                  final quicklist = model.allShopList;
                  print("Hello ${quicklist.length}");
                  if (quicklist.length != 0) {
                    return (quicklist.isEmpty)
                        ? Center(child: const CircularProgressIndicator())
                        : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quicklist.length,
                        itemBuilder: (BuildContext context, index) {
                          QuickCategoryModel quickcategory =
                          quicklist[index];
                          distanceCalculator(double.parse(quickcategory.latitude!), double.parse(quickcategory.longitude!), double.parse(quickcategory.deliveryArea!));

                          var open = [
                            quickcategory.lunchOpen,
                            quickcategory.lunchOpen,
                            quickcategory.dinnerOpen,
                            quickcategory.breakfastOpen,
                            quickcategory.openingTime
                          ];
                          var close = [
                            quickcategory.lunchClose,
                            quickcategory.lunchClose,
                            quickcategory.dinnerClose,
                            quickcategory.breakfastClose,
                            quickcategory.clossingTime
                          ];
                          return
                            // (quickcategory.products!.isEmpty ||
                            //   quickcategory.products == null)
                            //   ? Container()
                             // :
                          (checkAvailable(
                              open[_index], close[_index]) ==
                              true)
                          //     ?
                          // (inDistance == true)

                              ? InkWell(
                            onTap: () {
                              Get.to(
                                    () => KitchenPage(
                                  quickCategoryModel:
                                  quickcategory,
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 6),
                              child: QuickSellerCard(
                                  odelivery: quickcategory
                                      .deliveryTime
                                      .toString(),
                                  // time: quickcategory.openingTime
                                  //     .toString() +
                                  //     ' - ' +
                                  //     quickcategory.clossingTime
                                  //         .toString(),
                                  oimage: quickcategory.shopImage
                                      .toString(),
                                  oname: quickcategory.shopName
                                      .toString(),
                                  onavi: '',
                                  distance: quickcategory
                                      .distance!
                                      .substring(0, 3)),
                            ),
                          )
                              // :Container()
                              :Container();
                            //  :Container( child: Center(child: Text("No Active Kitchen")));
                          //     : Padding(
                          //   padding:
                          //   const EdgeInsets.only(top: 6),
                          //   child: GreyQuickSellerCard(
                          //       odelivery: quickcategory
                          //           .deliveryTime
                          //           .toString(),
                          //       time: quickcategory.openingTime
                          //           .toString() +
                          //           ' - ' +
                          //           quickcategory.clossingTime
                          //               .toString(),
                          //       oimage: quickcategory.shopImage
                          //           .toString(),
                          //       oname: quickcategory.shopName
                          //           .toString(),
                          //       onavi: '',
                          //       distance: quickcategory.distance!
                          //           .substring(0, 3)),
                          // );
                        });
                  } else {
                    return Padding(
                      padding:
                      EdgeInsets.only(top: screen.heigth(context) * 0.3),
                      child: Center(
                          child: kTextstyle(
                              myText: "No Product Found",
                              mySize: 16,
                              myWeight: FontWeight.w600,
                              myColor: kgreyColor)),
                    );
                  }
                }),
              ),
            ),
            // Text('data',style: TextStyle(letterSpacing: ),)
          ],
        ),
      ),
    );
  }
}