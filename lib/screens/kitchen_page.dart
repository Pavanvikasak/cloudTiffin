import 'dart:convert';

import 'package:cloud_tiffin/screens/new_cart_page.dart';
import 'package:cloud_tiffin/widgets/kitchenadd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../controllers/cart_controller.dart';
import '../helper/colors.dart';
import '../helper/screen_size.dart';
import '../helper/theme.dart';
import '../model/Quick_category_model.dart';
import 'bottom_navigation.dart';
// import '../provider/new_cart_provider.dart';

class KitchenPage extends StatefulWidget {
  final QuickCategoryModel? quickCategoryModel;

  const KitchenPage({Key? key, this.quickCategoryModel}) : super(key: key);

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  bool isVisible = false;

  dynamic getarguments = Get.arguments;

  // final String name = "kavita's Tiffin services";
  final String description =
      "veg, Snack, South indian, North indian, Fast food";
  // final String open = "7 am - 8 pm";
  // final String id = "01";
  // final String image = "assets/images/kit1.jpg";
  String? user_id;

  bool isFav = false;
  List<Map<String, String>> Totalitem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id');
    CartController cartController = Get.find(tag: "cart");
    cartController.getData();
    print(cartController.dataList.length);
    if (cartController.dataList.isNotEmpty) {
      // print("Cart is empty");
      // Fluttertoast.showToast(msg: "Cart is empty");
      showDataAlert(context, user_id);
    } else {
      //   Fluttertoast.showToast(msg: "Cart is empty");

    }
  }

  Future delete_cart(user_id) async {
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/delete_cart2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // "product_id"  :   productid  ,
        "user_id": user_id,
        //  "vendor_id"   :     widget.newallkitchenmodel.products.,
      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      Navigator.of(context).pop();
      print(data['ResponseMsg']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${data['ResponseMsg']}"),
      ));
      CartController cartController = Get.find(tag: "cart");
      cartController.dataList.clear();
      setState(() {
        // CartController cartController=Get.find(tag: "cart");
        // cartController.getData();
      });
    } else {
      print(data['ResponseMsg']);
    }
  }

  showDataAlert(context, user_id) {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              bool check = false;
              if (check == false) {
                Get.off(() => const BotNav());
              }
              return check;
            },
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              title: Column(
                children: [
                  kTextstyle(
                      myText: "Your cart has already product ",
                      mySize: 16,
                      space: 0.2,
                      myWeight: FontWeight.w600,
                      myColor: kgreyColor),
                  // kTextstyle(
                  //     myText: "diffrent kitchen provider",
                  //     mySize: 16,
                  //     space: 0.2,
                  //     myWeight: FontWeight.w600,
                  //     myColor: kgreyColor),
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
                            Get.to(const NewCartPage());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kredColor,
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "View Cart",
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
                          delete_cart(user_id);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kredColor,
                          // fixedSize: Size(250, 50),
                        ),
                        child: const Text(
                          "Clear Cart",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<NewCartProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              width: screen.width(context),
              height: screen.heigth(context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.quickCategoryModel!.shopImage.toString()),
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
                              myText: widget.quickCategoryModel!.shopName
                                  .toString(),
                              myWeight: FontWeight.w700),
                          const SizedBox(
                            height: 8,
                          ),
                          kTextstyle(
                              mySize: 14,
                              myText: widget.quickCategoryModel!.description
                                  .toString(),
                              lines: 4,
                              myWeight: FontWeight.w500,
                              myColor: Colors.grey),
                          const SizedBox(
                            height: 8,
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
                                          '${widget.quickCategoryModel!.deliveryTime} min',
                                      mySize: 16,
                                      myColor: kgreenColor),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  kTextstyle(
                                      myText: "Delivery Time",
                                      mySize: 14,
                                      myWeight: FontWeight.w500)
                                ],
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     kTextstyle(
                          //         mySize: 14,
                          //         myText: "Open on",
                          //         myWeight: FontWeight.w600,
                          //         myColor: Colors.green),
                          //     const SizedBox(
                          //       width: 8,
                          //     ),
                          //     kTextstyle(
                          //         mySize: 14,
                          //         myText: widget
                          //             .quickCategoryModel!.openingTime
                          //             .toString() +
                          //             "  - " +
                          //             widget.quickCategoryModel!.clossingTime
                          //                 .toString(),
                          //         myWeight: FontWeight.normal),
                          //   ],
                          // ),
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
                          // Padding(
                          //   padding: const EdgeInsets.all(16),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //     MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           Row(
                          //             children: [
                          //               Icon(Icons.star_border,
                          //                   color: kgreenColor, size: 18),
                          //               SizedBox(
                          //                 width: 4,
                          //               ),
                          //               kTextstyle(
                          //                   myText: '4',
                          //                   mySize: 18,
                          //                   myColor: kgreenColor)
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 4,
                          //           ),
                          //           kTextstyle(
                          //               myText: "Rating",
                          //               mySize: 14,
                          //               myWeight: FontWeight.w500)
                          //         ],
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 16),
                          //         child: Container(
                          //           height: 42,
                          //           width: 2,
                          //           color: kredColor.withOpacity(0.08),
                          //         ),
                          //       ),
                          //       Column(
                          //         children: [
                          //           Row(
                          //             children: [
                          //               Icon(FontAwesome.clock_o,
                          //                   color: kgreenColor, size: 16),
                          //               SizedBox(
                          //                 width: 8,
                          //               ),
                          //               kTextstyle(
                          //                   myText: widget.quickCategoryModel!
                          //                       .deliveryTime
                          //                       .toString(),
                          //                   mySize: 16,
                          //                   myColor: kgreenColor)
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 6,
                          //           ),
                          //           kTextstyle(
                          //               myText: "Delivery Time",
                          //               mySize: 14,
                          //               myWeight: FontWeight.w500)
                          //         ],
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 16),
                          //         child: Container(
                          //           height: 42,
                          //           width: 2,
                          //           color: kredColor.withOpacity(0.08),
                          //         ),
                          //       ),
                          //       Column(
                          //         children: [
                          //           Row(
                          //             children: [
                          //               Icon(
                          //                 Icons.thumb_up,
                          //                 color: kgreenColor,
                          //                 size: 18,
                          //               ),
                          //               SizedBox(
                          //                 width: 4,
                          //               ),
                          //               kTextstyle(
                          //                   myText: '4',
                          //                   mySize: 18,
                          //                   myColor: kgreenColor)
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 4,
                          //           ),
                          //           kTextstyle(
                          //               myText: "Reviews",
                          //               mySize: 14,
                          //               myWeight: FontWeight.w500)
                          //         ],
                          //       ),
                          //
                          //       // Padding(
                          //       //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //       //   child: Container(height: 42,
                          //       //     width: 2,
                          //       //     color: kgreenColor,),
                          //       // )
                          //     ],
                          //   ),
                          // ),

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
                            padding: const EdgeInsets.only(left: 16),
                            child: kTextstyle(
                                myText: "Menu",
                                mySize: 16,
                                myWeight: FontWeight.w700),
                          ),
                          // Text('data',style: TextStyle(wordSpacing: ),)
                          if (widget.quickCategoryModel!.products!.isEmpty)
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
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: widget
                                        .quickCategoryModel?.products!.length,
                                    itemBuilder:
                                        (BuildContext context, product) {
                                      // QuickCategoryModel data ;
                                      // var data = widget
                                      //     .newallkitchenmodel!.products!;
                                      QuickCategoryModel all =
                                          widget.quickCategoryModel!;
                                      var data = all.products!;

                                      return (data[product].leftqty != "0" ||
                                              data[product].leftqty == null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Container(
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        offset:
                                                            const Offset(0, 0),
                                                        blurRadius: 6,
                                                      )
                                                    ]),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12,
                                                              top: 12),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          kTextstyle(
                                                              mySize: 14,
                                                              myText: data[
                                                                      product]
                                                                  .name
                                                                  .toString(),
                                                              myWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          kTextstyle(
                                                              mySize: 12,
                                                              myText:
                                                                  "Qty left : ${data[product].leftqty.toString()}",
                                                              myWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          // kTextstyle(myText: "Qty left : ${data[product].qty}",
                                                          //     myWeight: FontWeight.w600),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .currency_rupee_outlined,
                                                                size: 18,
                                                              ),
                                                              kTextstyle(
                                                                  mySize: 18,
                                                                  myText: data[
                                                                          product]
                                                                      .price
                                                                      .toString(),
                                                                  myWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ],
                                                          ),
                                                          kTextstyle(
                                                              mySize: 12,
                                                              myText: data[
                                                                      product]
                                                                  .description
                                                                  .toString(),
                                                              lines: 2),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    IconButton(
                                                                  splashRadius:
                                                                      1,
                                                                  iconSize: 16,
                                                                  icon: isFav
                                                                      ? Icon(
                                                                          Icons
                                                                              .favorite_outlined,
                                                                          size:
                                                                              24,
                                                                          color:
                                                                              kredColor,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .favorite_border_rounded,
                                                                          size:
                                                                              24,
                                                                          color:
                                                                              kredColor,
                                                                        ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      this.isFav =
                                                                          !this
                                                                              .isFav;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              Container(
                                                                height: 24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                          .grey[
                                                                      350],
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          2),
                                                                  child: Row(
                                                                    children: [
                                                                      kTextstyle(
                                                                          myText:
                                                                              "4.5",
                                                                          mySize:
                                                                              14,
                                                                          myWeight:
                                                                              FontWeight.w500),
                                                                      const SizedBox(
                                                                        width:
                                                                            4,
                                                                      ),
                                                                      const Icon(
                                                                        Icons
                                                                            .star,
                                                                        size:
                                                                            18,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12,
                                                                  right: 12,
                                                                  top: 12),
                                                          child: Container(
                                                            width: 108,
                                                            height: 98,
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            4),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: kredColor.withOpacity(
                                                                              0.2),
                                                                          blurRadius:
                                                                              6)
                                                                    ],

                                                                    /// networkimage
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(data[product]
                                                                            .thumbnail
                                                                            .toString()),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),

                                                        ///=================================================================,
                                                        ///=================================================================,
                                                        ///===== Add counter===================================================
                                                        ///=================================================================
                                                        KitchenAddButton(
                                                          // index: product.toString(),
                                                          name: data[product]
                                                              .name!,
                                                          vendorid:
                                                              data[product]
                                                                  .vendorId,
                                                          userid: "$user_id",
                                                          productid:
                                                              data[product].id,
                                                          price: data[product]
                                                              .price,
                                                          qty: '1',
                                                          image: data[product]
                                                              .thumbnail,
                                                          totalprice:
                                                              data[product]
                                                                  .price,
                                                          globalid:
                                                              data[product]
                                                                  .vendorId,
                                                          //  isSelected: data[product].isSelected,
                                                          isQty: data[product]
                                                              .isQty,
                                                          leftqty: data[product]
                                                              .leftqty,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                          : Container();
                                    },
                                  );
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
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: size.height * 0.01, left: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            this.isFav = !this.isFav;
                          });
                        },
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: [
                                isFav
                                    ? BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                      )
                                    : const BoxShadow(color: Colors.white)
                              ]),
                          child: isFav
                              ? Icon(
                                  Icons.favorite_outlined,
                                  color: kredColor,
                                )
                              : Icon(
                                  Icons.favorite_border_rounded,
                                  color: kredColor,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.01, left: 16, right: 16),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.8)),
                        child: Icon(Icons.share, color: kredColor),
                      ),
                    ),
                  ],
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
}

/// Bottom sheet ===============================================================================================================
//
// Row(
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 24),
// child: kTextstyle(
// myText: "${service.length}  items",
// mySize: 16,
// myWeight: FontWeight.w600,
// myColor: kwhiteColor),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 12, vertical: 12),
// child: Container(
// width: 2,
// height: 36,
// color: kwhiteColor,
// ),
// ),
// Icon(
// Icons.currency_rupee,
// size: 20,
// color: kwhiteColor,
// ),
// kTextstyle(
// myText: '                 ',
// mySize: 20,
// myColor: kwhiteColor,
// myWeight: FontWeight.w600)
// ],
// ),

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
