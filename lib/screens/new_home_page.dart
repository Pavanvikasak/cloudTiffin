import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_tiffin/helper/handleFirebaseNotification.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/all_kitchen_list.dart';
import 'package:cloud_tiffin/screens/change_address_page.dart';
import 'package:cloud_tiffin/screens/new_cart_page.dart';
import 'package:cloud_tiffin/screens/new_kitchen_page.dart';
import 'package:cloud_tiffin/screens/quick_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cards.dart';
import '../config.dart';
import '../controllers/cart_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/kitchen_controller.dart';
import '../helper/colors.dart';
import '../helper/handleLocalNotification.dart';
import '../helper/theme.dart';
import '../model/CategoryModel.dart';
import '../model/NewAllKitchenModel.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  //dynamic argumentData = Get.arguments;
  // late  String? latitude;
  // late  String? longitude;
  //KitchenController _kitchenController;
  late KitchenController _kitchenController;
  late CartController _cartController;
  late CategoryController _categoryController;
  double? latitude;
  double? longitude;
  String? address;
  Timer? _timer;
  int? _start;

  final List imagesList = [];
  bool isLoading = false;
  bool inDistance = false;
  final Distance distance = const Distance();

  late String token;
  @override
  initState() {
    super.initState();
    _get_session();
    loadbannerData();
    HandleFirebaseNotification.handleNotifications(context);
    HandleLocalNotification.initializeFlutterNotification(context);
    _kitchenController = Get.put(KitchenController(), tag: "kitchen");
    _categoryController = Get.put(CategoryController(), tag: "category");
    _cartController = Get.put(CartController(), tag: "cart");
    // startTimer(3000);
    if (mounted) {
      _timer = Timer.periodic(
          const Duration(seconds: 30),
          (Timer t) =>

              //  setState(() {
              _pullRefresh()
          //  })
          );
    }
    // _cartController= Get.put(CartController(),tag: "cart");
  }

  // @override
  // void dispose() {
  //
  //   super.dispose();
  // }
  Future<void> loadbannerData() async {
    setState(() {
      isLoading = true;
    });
    print("hello banner");

    var response = await http.get(Uri.parse('${Config.BASEURL}user/banner'));

    final data = json.decode(response.body);
    print("hello banner 2");
    print(data);
    final List responseBody = data['BannerData'];

    // imagesList.addAll(data['BannerData']) ;

    for (var i in responseBody) {
      setState(() {
        imagesList.add(
          i['thumbnail'],
        );
      });
      print("gfhgvhg $imagesList");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // user_id = prefs.getString('id');
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
      address = prefs.getString('address');
    });
  }

  List<int> id = [0, 1, 2, 3, 4];
  List image = [
    'assets/images/bf.jpg',
    'assets/images/lu.jpg',
    'assets/images/sn.jpg',
    'assets/images/di.jpg'
  ];

  // List name = ['BREAKFAST', 'LUNCH', 'SNACKS', 'DINNER'];
  List foodi = [
    'assets/images/pizza.jpg',
    'assets/images/chow.jpg',
    'assets/images/pizza.jpg',
    'assets/images/lu.jpg',
    'assets/images/chow.jpg',
  ];
  List product_name = [
    'Cheese pizza',
    'Chowmien',
    "kavita's kitchen",
    'savita food paradies',
    'grill & chill'
  ];
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final Kitchen = Provider.of<KitchenProvider>(context);

    // Start the timer

    return Scaffold(
      // appBar: CAppBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: kblackcolor,
        backgroundColor: kwhiteColor,
        leadingWidth: 0,
        title: InkWell(
          onTap: () {
            Get.to(() => ChangeAddressPage());
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: kredColor,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    kTextstyle(
                        myText: 'Location'.toUpperCase(),
                        mySize: 16,
                        space: 0.18,
                        myColor: kgreyColor,
                        myWeight: FontWeight.w600),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: kTextstyle(
                      myText: "$address",
                      space: 0.6,
                      myColor: kgreyColor,
                      mySize: 14,
                      myWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        shadowColor: kwhiteColor.withOpacity(0.1),
        actions: [
          InkWell(
            onTap: () {
              // Get.to(CartListPage());
              Get.to(const NewCartPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: _handle_build_cart(),
                //AppBarActionWidgets().cartWidget(context),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     FirebaseMessaging.instance.getToken().then((value) {
              //       setState(() {
              //         token = value!;
              //       });
              //       print(value);
              //     });
              //     HandleFirebaseNotification.sendPushMessage(
              //         token, 'testing', 'testing notification');
              //   },
              //   child: Text('send Notification'),
              // ),

              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 16, left: 16, right: 16, bottom: 24),
              //   child: Container(
              //     height: 160,
              //     width: double.maxFinite,
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage('assets/images/ban.jpg'),
              //             fit: BoxFit.cover),
              //         borderRadius: BorderRadius.circular(8),
              //         boxShadow: [
              //           BoxShadow(
              //               color: kblackcolor.withOpacity(0.025),
              //               blurRadius: 2.0,
              //               offset: Offset(0, 8))
              //         ]),
              //   ),
              // ),
              imagesList.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                      color: kredColor,
                    ))
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 24),
                      child: CarouselSlider(
                        items: imagesList
                            .map((url) => Container(
                                  height: 170,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(url),
                                        fit: BoxFit.cover),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.5,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
              Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 8),
                  child: kTextstyle(
                      myText: 'Quick search',
                      mySize: 18,
                      myWeight: FontWeight.w600)),
              _handle_build_category(),

              const SizedBox(height: 18),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 14),
                      child: kTextstyle(
                          myText: 'Top 5 kitchens',
                          mySize: 18,
                          myWeight: FontWeight.w600)),
                  const SizedBox(width: 100),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AllKitchenScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: kTextstyle(
                          myText: "View All",
                          mySize: 17,
                          myWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AllKitchenScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  )
                ],
              ),
              _handle_build_all_kitchen(),

              const SizedBox(
                height: 18,
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: double.maxFinite,
              //     height: 104,
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
              //     color: kgreenColor
              //     ),
              //
              //     child:  AddButton(),
              //   ),
              // ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handle_build_cart() {
    return Obx(() {
      if (!_cartController.isError.value) {
        // if no any error
        if (_cartController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: kredColor,
            ),
          );
          // return IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => NewCartPage(
          //         ),
          //       ),
          //     );
          //
          //   }, icon: Icon(Icons.shopping_cart),
          // );
        } else if (_cartController.dataList.isEmpty) {
          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewCartPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),
              const Positioned(
                  top: 5,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ))
            ],
          );
        } else {
          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewCartPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                  top: 5,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      "${_cartController.dataList.length}",
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ))
            ],
          );
        }
      } else {
        //return Text("");
        return IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewCartPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.shopping_cart,
          ),
        );
      } //Error svg
    });
  }

  _handle_build_all_kitchen() {
    print("hello yd");
    return Container(
      child: Obx(() {
        if (!_kitchenController.isError.value) {
          // if no any error
          if (_kitchenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: kredColor,
              ),
            );
          } else if (_kitchenController.dataList.length == 0) {
            return const Text(""); // NoDataWidget(); // No data svg
          } else {
            return _buildListView(_kitchenController.dataList);
          }
        } else {
          return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Center(child: Text("No Kitchen is active")),
          );
        } //IErrorWidget(); //Error svg
      }),
    );
  }

  Future<void> _pullRefresh() async {
    _kitchenController.getData();
    _categoryController.getData();
    // CartController cartController=Get.find(tag: "cart");
    // cartController.dataList.refresh();
    // cartController.getData();
    _cartController.getData();
    // AppBarActionWidgets().cartWidget(context);
    // _handle_build_category();
    // _handle_build_all_kitchen();
    setState(() {});
  }

  distanceCalculator(double lat2, double long2, double Distance) async {
    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();
    double lat1 = double.parse(latitude);
    double long1 = double.parse(longitude);

    final double km = distance.as(
        LengthUnit.Kilometer, LatLng(lat1, long1), LatLng(lat2, long2));

    print(" calulate $km");
    print("distance  $Distance");
    if (km < Distance) {
      print(true);
      // status=true;
      setState(() {
        inDistance = true;
      });
      return inDistance;
    } else {
      // status=false;
      setState(() {
        inDistance = false;
      });
      // print(false);
      return inDistance;
    }
  }

  _buildListView(newKitchenList) {
    print("hello ////$newKitchenList");

    return ListView.builder(
        shrinkWrap: true,
        itemCount: (newKitchenList.length < 5 || newKitchenList.isEmpty)
            ? newKitchenList.length
            : 5,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, index) {
          NewAllKitchenModel quick = newKitchenList[index];
          // print("${allTimingCheck(index)} ==================================");
          distanceCalculator(
              double.parse(quick.latitude!),
              double.parse(quick.longitude!),
              double.parse(quick.deliveryArea!));

          bool status = false;

          return (allTimeStatus(
                      quick.breakfastOpen,
                      quick.breakfastClose,
                      quick.lunchOpen,
                      quick.lunchClose,
                      quick.dinnerOpen,
                      quick.dinnerClose) ==
                  true)
              ?
              // (checkAvailable(quick.breakfastOpen.toString(), quick.breakfastClose.toString()))?
              //_isDistanceCalculaitng?CircularProgressIndicator(color: kredColor,):
              //     (inDistance == true)
              //       ?
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => NewKitchenPage(
                              newallkitchenmodel: quick,
                            ));
                      },
                      child: KitchenCard(
                        odelivery: quick.deliveryTime!,
                        oimage: quick.shopImage.toString(),
                        oname: quick.shopName.toString(),
                        About: quick.description != null
                            ? quick.description.toString()
                            : " ",
                        distance: quick.distance!.substring(0, 3),
                      )),
                )
              //:

              // : Container():
              : Container();
          //     : Padding(
          //   padding: const EdgeInsets.symmetric(
          //       vertical: 4, horizontal: 16),
          //       child:GreyKitchenCard(
          //     odelivery: quick.deliveryTime!,
          //     oimage: quick.shopImage.toString(),
          //     oname: quick.shopName.toString(),
          //     About:
          //     quick.description.toString(),
          //     distance:quick.distance!.substring(0, 3),
          //
          //   ),
          //
          // );
          // GestureDetector(
          //   onTap: () {
          //     Get.to(() =>NewKitchenPage(
          //       newallkitchenmodel: quick,
          //     ));
          //
          //
          //
          //   },
          //   child:
          //   ThumbnailContainer(
          //     name: quick.shopName.toString(),
          //     tags: quick.openingTime.toString() + " - " +
          //         quick.clossingTime.toString(),
          //     time: quick.deliveryTime,
          //     image: quick.shopImage.toString(),
          //   ),
          // )
          //     : GreyThumbnailContainer(name: quick.shopName.toString(), image: quick.shopImage.toString(), tags:  quick.openingTime.toString() + " - " +
          //     quick.clossingTime.toString(), time: quick.deliveryTime);
        });
  }

  _handle_build_category() {
    print("hello yd");
    return Container(
      child: Obx(() {
        if (!_categoryController.isError.value) {
          // if no any error
          if (_categoryController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: kredColor,
              ),
            );
          } else if (_categoryController.dataList.length == 0) {
            return const Text("hello yd"); // NoDataWidget(); // No data svg
          } else {
            return _buildCategoryListView(_categoryController.dataList);
          }
        } else {
          return const Text("");
        } //IErrorWidget(); //Error svg
      }),
    );
  }

  _buildCategoryListView(newCategoryList) {
    print("hello ////$newCategoryList");

    return Container(
      width: screen.width(context),
      height: 132,
      child: ListView.builder(
          itemCount: newCategoryList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            CategoryModel food = newCategoryList[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const QuickSearchScreen(), arguments: [
                    {'cat_id': food.id},
                    {'name': food.name},
                    // {
                    //   'latitude': latitude
                    //   // Get.arguments[0]['latitude']
                    //   // 22.008951
                    // },
                    // {
                    //   // 'longitude': 81.224342
                    // 'longitude': longitude
                    // // Get.arguments[1]['longitude']
                    // }
                  ]);

                  // Navigator.pushNamed(
                  //     context, MyRoutes.KitchenPage);
                },
                child: Container(
                  width: screen.width(context) * .220,
                  height: 124,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: kblackcolor.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 2))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 93,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                          image: DecorationImage(
                              image: NetworkImage(food.thumbnail!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kwhiteColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 8),
                                child: kTextstyle(
                                    lines: 2,
                                    myDirection: TextAlign.center,
                                    myText: food.name!,
                                    mySize: 11,
                                    myWeight: FontWeight.w500))),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// ThumbnailContainer(
// name: "kavita's kitchen",
// tags: "Best Food, chinese, Biriyani",
// time: '12 min',
// image: 'assets/images/lu.jpg',
// ),
