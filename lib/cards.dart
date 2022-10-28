import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/provider/cart_provider.dart';
import 'package:cloud_tiffin/provider/new_cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

// import 'package:get/get.dart';
import 'helper/colors.dart';
import 'helper/theme.dart';

class quickSearch extends StatelessWidget {
  const quickSearch({Key? key, required this.image, required this.name})
      : super(key: key);
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 98,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: kblackcolor.withOpacity(0.1),
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 86,
            width: 124,
          ),
          Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Breakfast',
                  style: theme.textTheme.bodySmall,
                ),
              ))
        ],
      ),
    );
  }
}

class ThumbnailContainer extends StatefulWidget {
  const ThumbnailContainer({
    Key? key,
    required this.name,
    required this.image,
    required this.tags,
    required this.time,
  }) : super(key: key);
  final String image;
  final String name;
  final String? tags;
  final String? time;

  @override
  State<ThumbnailContainer> createState() => _ThumbnailContainerState();
}

class _ThumbnailContainerState extends State<ThumbnailContainer> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 326,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.time == null)? Container(): Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: kwhiteColor,
                      boxShadow: [BoxShadow(
                          color: kblackcolor.withOpacity(0.12),
                          offset: Offset(0,2),
                          blurRadius: 4
                      )],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4)),
                    ),
                    child:
                    Row(
                      children: [
                        Icon(
                          FontAwesome5.clock,
                          // Icons.punch_clock_outlined,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        kTextstyle(myText: '${widget.time}', mySize: 12,myWeight: FontWeight.w600),
                        SizedBox(width: 5,),
                        kTextstyle(myText: '(min)', mySize: 10,myColor: kgreyColor),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        this.isFav = !isFav;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              isFav
                                  ? BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 12,
                              )
                                  : BoxShadow()
                            ]),
                        child: isFav
                            ? Icon(
                          Icons.favorite_outlined,
                          color: kredColor,
                          size: 28,
                        )
                            : Icon(
                          Icons.favorite_border_rounded,
                          color: kredColor,
                          size: 28,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 172,
            ),
            Container(
              height: 76,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: Colors.white),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 12, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTextstyle(
                              myText: widget.name,
                              mySize: 18,
                              myWeight: FontWeight.w600),
                          Row(
                            children: [
                              kTextstyle(
                                myText: "Open Timing  - ",
                                mySize: 12,
                                myColor: kgreyColor,
                                myWeight: FontWeight.w600,
                              ),
                              kTextstyle(
                                myText: "${widget.tags}",
                                mySize: 12,
                                myWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, top: 12),
                    child: Container(
                      height: 20,
                      width: 44,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          kTextstyle(
                              myText: '4.4', mySize: 12, myColor: kwhiteColor),
                          Icon(
                            Icons.star,
                            size: 12,
                            color: kwhiteColor,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




////////===================================================================================================

class GreyThumbnailContainer extends StatefulWidget {
  final String image;
  final String name;
  final String? tags;
  final String? time;
  const GreyThumbnailContainer({Key? key,
    required this.name,
    required this.image,
    required this.tags,
    required this.time,}) : super(key: key);

  @override
  State<GreyThumbnailContainer> createState() => _GreyThumbnailContainerState();
}

class _GreyThumbnailContainerState extends State<GreyThumbnailContainer> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 326,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.image), colorFilter: ColorFilter.mode(kgreyColor!, BlendMode.color),fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(18),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.black.withOpacity(0.2),
          //       spreadRadius: 1,
          //       blurRadius: 2,
          //       offset: Offset(0, 2))
          // ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.time == null)? Container(): Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: kwhiteColor,
                      boxShadow: [BoxShadow(
                          color: kblackcolor.withOpacity(0.12),
                          offset: Offset(0,2),
                          blurRadius: 4
                      )],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4)),
                    ),
                    child:
                    Row(
                      children: [
                        Icon(
                          FontAwesome5.clock,
                          // Icons.punch_clock_outlined,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        kTextstyle(myText: '${widget.time}', mySize: 12,myWeight: FontWeight.w600),
                        SizedBox(width: 5,),
                        kTextstyle(myText: '(min)', mySize: 10,myColor: kgreyColor),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        this.isFav = !isFav;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              isFav
                                  ? BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 12,
                              )
                                  : BoxShadow()
                            ]),
                        child: isFav
                            ? Icon(
                          Icons.favorite_outlined,
                          color: kredColor,
                          size: 28,
                        )
                            : Icon(
                          Icons.favorite_border_rounded,
                          color: kredColor,
                          size: 28,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 172,
            ),
            Container(
              height: 76,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: Colors.grey.shade400),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 12, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTextstyle(myText: "Closed Now" ,mySize: 16,myWeight: FontWeight.w700,space: 0.8),
                          kTextstyle(
                              myText: widget.name,
                              mySize: 14,myColor: kgreyColor,
                              myWeight: FontWeight.w600),
                          Row(
                            children: [
                              kTextstyle(
                                myText: "Open Timing  - ",
                                mySize: 12,
                                myColor: kgreyColor,
                                myWeight: FontWeight.w600,
                              ),
                              kTextstyle(
                                myText: "${widget.tags}",
                                mySize: 12,
                                myWeight: FontWeight.w400,
                              ),
                            ],
                          ),

                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, top: 12),
                    child: Container(
                      height: 20,
                      width: 44,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          kTextstyle(
                              myText: '4.4', mySize: 12, myColor: kwhiteColor),
                          Icon(
                            Icons.star,
                            size: 12,
                            color: kwhiteColor,
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}






class GreyQuickSellerCard extends StatefulWidget {
  final String oimage;
  final String oname;
  final String odelivery;
  final String distance;
  final String onavi;
  final String time;
  const GreyQuickSellerCard({Key? key,
    required this.odelivery,
    required this.time,
    required this.oimage,
    required this.oname,
    required this.onavi,
    required this.distance
  }) : super(key: key);

  @override
  State<GreyQuickSellerCard> createState() => _GreyQuickSellerCardState();
}

class _GreyQuickSellerCardState extends State<GreyQuickSellerCard> {
  bool fav = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 16, left: 18, right: 12, bottom: 16),
      height: 144,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
      ),
      child: SizedBox(
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Container(
              height: double.maxFinite,
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(widget.oimage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.asset(,width: 108,height: double.maxFinite,fit: BoxFit.cover,),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kTextstyle(myText: "Closed Now " ,mySize: 16,myWeight: FontWeight.w700,space: 0.8),
                  // Flexible(child: Text(widget.oname, style: TextStyle(fontSize: 12),)),
                  Flexible(
                      flex: 1,
                      child: kTextstyle(
                          myText: widget.oname,
                          mySize: 14,myColor: Colors.grey,
                          myWeight: FontWeight.w600)),

                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 14,
                        color: kgreenColor,
                      ),
                      kTextstyle(
                          myText: widget.odelivery,
                          mySize: 14,
                          myColor: Colors.grey,
                          myWeight: FontWeight.w600),
                      kTextstyle(
                          myText: '  min',
                          mySize: 12,
                          myColor: Colors.grey,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    children: [
                      kTextstyle(
                        myText: "distance :",
                        mySize: 12,
                        myColor: Colors.grey,),
                      SizedBox(
                        width: 4,
                      ),
                      kTextstyle(
                        myText: widget.distance,
                        mySize: 12,
                        myColor: Colors.grey,),
                      kTextstyle(
                          myText: '  km',
                          mySize: 12,
                          myColor: Colors.grey,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    children: [
                      kTextstyle(
                        myText: "Time : ", mySize: 12,myColor: Colors.grey,),
                      SizedBox(
                        width: 2,
                      ),
                      kTextstyle(
                          myText: widget.time,
                          mySize: 12,
                          myColor: Colors.grey,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: (){
                //
                //     setState(() {
                //
                //       fav = false;
                //
                //     });
                //     toast(fav);
                //
                //   },
                //   icon :  Icon((fav = true )? Icons.favorite_outline : Icons.favorite ),iconSize: 16,
                // ),

                /// non veg mark
                // Container(
                //     height: 18,
                //     width: 18,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: kredColor, width: 2)),
                //     child: Icon(
                //       Icons.circle,
                //       size: 10,
                //       color: Colors.red,
                //     ))
                // Icon(Icons.favorite, size: 16, ),
                // Icon(Icons.share, size: 16,),
                // Icon(Icons.more_vert_sharp, size: 16,)
                // IconButton(
                //     onPressed: (){
                //       Navigator.pushNamed(context, MyRoutes.SharePage);
                //     }, icon: Icon(Icons.share,size: 12,)),
                //   IconButton(
                //       onPressed: (){
                //         Navigator.pushNamed(context, MyRoutes.SharePage);
                //       }, icon: Icon(Icons.share,size: 12,))
              ],
            )
          ],
        ),
      ),
    );
  }
}


class QuickSellerCard extends StatefulWidget {
  final String oimage;
  final String oname;
  final String odelivery;
  final String distance;
  final String onavi;
  //final String time;

  const QuickSellerCard(
      {Key? key,
        required this.odelivery,
     //   required this.time,
        required this.oimage,
        required this.oname,
        required this.onavi,
        required this.distance})
      : super(key: key);

  @override
  State<QuickSellerCard> createState() => _QuickSellerCardState();
}

class _QuickSellerCardState extends State<QuickSellerCard> {
  bool fav = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 16, left: 18, right: 12, bottom: 16),
      height: 112,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Color(0xffDADADA)),
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.08),
                blurRadius: 2,
                offset: Offset(0, 4))
          ]),
      child: SizedBox(
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Container(
              height: double.maxFinite,
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(widget.oimage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.asset(,width: 108,height: double.maxFinite,fit: BoxFit.cover,),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Flexible(child: Text(widget.oname, style: TextStyle(fontSize: 12),)),
                  Flexible(
                      flex: 1,
                      child: kTextstyle(
                          myText: widget.oname,
                          mySize: 14,
                          myWeight: FontWeight.w600)),

                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 14,
                        color: kgreenColor,
                      ),
                      kTextstyle(
                          myText: widget.odelivery,
                          mySize: 14,
                          myColor: kgreyColor,
                          myWeight: FontWeight.w600),
                      kTextstyle(
                          myText: '  min',
                          mySize: 12,
                          myColor: kgreyColor,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    children: [
                      kTextstyle(
                          myText: "distance :",
                          mySize: 12,
                          myColor: Colors.black),
                      SizedBox(
                        width: 4,
                      ),
                      kTextstyle(
                          myText: widget.distance,
                          mySize: 12,
                          myColor: Colors.black),
                      kTextstyle(
                          myText: '  km',
                          mySize: 12,
                          myColor: Colors.black,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     kTextstyle(
                  //         myText: "Time : ", mySize: 12, myColor: Colors.black),
                  //     SizedBox(
                  //       width: 2,
                  //     ),
                  //     kTextstyle(
                  //         myText: widget.time,
                  //         mySize: 12,
                  //         myColor: Colors.black,
                  //         myWeight: FontWeight.w600),
                  //   ],
                  // ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: (){
                //
                //     setState(() {
                //
                //       fav = false;
                //
                //     });
                //     toast(fav);
                //
                //   },
                //   icon :  Icon((fav = true )? Icons.favorite_outline : Icons.favorite ),iconSize: 16,
                // ),

                /// non veg mark
                // Container(
                //     height: 18,
                //     width: 18,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: kredColor, width: 2)),
                //     child: Icon(
                //       Icons.circle,
                //       size: 10,
                //       color: Colors.red,
                //     ))
                // Icon(Icons.favorite, size: 16, ),
                // Icon(Icons.share, size: 16,),
                // Icon(Icons.more_vert_sharp, size: 16,)
                // IconButton(
                //     onPressed: (){
                //       Navigator.pushNamed(context, MyRoutes.SharePage);
                //     }, icon: Icon(Icons.share,size: 12,)),
                //   IconButton(
                //       onPressed: (){
                //         Navigator.pushNamed(context, MyRoutes.SharePage);
                //       }, icon: Icon(Icons.share,size: 12,))
              ],
            )
          ],
        ),
      ),
    );
  }
}

//kitchen card

class FoodCard extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String id;
  final String price;
  final String category;
  final Function addbutton;

  const FoodCard({
    Key? key,
    required this.name,
    required this.addbutton,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.id,
  }) : super(key: key);

  @override
  State<FoodCard> createState() => _FoodCardState();
}

/// food cart function
/// setState(() {
//           showModalBottomSheet(
//             enableDrag: true,
//             // elevation: 5,
//             isScrollControlled: true,
//             context: context,
//             isDismissible: true,
//             backgroundColor: Colors.transparent,
//             builder: (context) => PopFoodCart(counter: _counter),
//           );
//         });

class _FoodCardState extends State<FoodCard> {
  bool isFav = false;
  dynamic _counter = 0;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 0),
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
                        mySize: 14, myText: widget.name, myWeight: FontWeight.w600),
                    kTextstyle(
                        mySize: 12, myText: widget.category, myColor: Colors.grey),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_outlined,
                          size: 18,
                        ),
                        kTextstyle(
                            mySize: 18,
                            myText: widget.price,
                            myWeight: FontWeight.w600),
                      ],
                    ),
                    kTextstyle(mySize: 12, myText: widget.description, lines: 2),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            splashRadius: 1,
                            iconSize: 16,
                            icon: isFav
                                ? Icon(
                              Icons.favorite_outlined,
                              size: 24,
                              color: kredColor,
                            )
                                : Icon(
                              Icons.favorite_border_rounded,
                              size: 24,
                              color: kredColor,
                            ),
                            onPressed: () {
                              setState(() {
                                this.isFav = !this.isFav;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[350],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: Row(
                              children: [
                                kTextstyle(
                                    myText: "4.5",
                                    mySize: 14,
                                    myWeight: FontWeight.w500),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 18,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Container(
                  width: 108,
                  height: 98,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                            color: kredColor.withOpacity(0.2), blurRadius: 6)
                      ],

                      /// networkimage
                      image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.addbutton;
                    });
                  },
                  child: Container(
                    width: 86,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kredColor, width: 1)),
                    child: kTextstyle(
                        myText: 'add +', mySize: 14, myWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

/// add remove code
//
//                     :


enum Deliverytype { name1,name2,name3, }
class PopFoodCart extends StatefulWidget {
  late dynamic counter;

  PopFoodCart({Key? key, required this.counter}) : super(key: key);

  @override
  State<PopFoodCart> createState() => _PopFoodCartState();
}

class _PopFoodCartState extends State<PopFoodCart> {
  // dynamic GetArguments = Get.arguments();
  Deliverytype _value = Deliverytype.name1;

  // int _counter = Get.arguments[0]['counter'];
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      // expand: true,
      // snap: true,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (_, controller) => Container(
        width: screen.width(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            color: Colors.white),
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16),
          shrinkWrap: true,
          controller: controller,
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                kTextstyle(
                    myText: 'Select Date & Time',
                    mySize: 16,
                    myWeight: FontWeight.w600,
                    myColor: Colors.grey),
                kTextstyle(
                    myText: 'Fri Apr 08 2022',
                    mySize: 24,
                    myWeight: FontWeight.w600)
              ],
            ),
            SizedBox(
              height: 16,
            ),
            kTextstyle(
                myText: 'Select Mode', mySize: 16, myWeight: FontWeight.w600),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                        value: Deliverytype.name2,
                        groupValue: _value,
                        onChanged: (Deliverytype? val) {
                          setState(() {
                            _value = val!;
                          });
                        }),
                    kTextstyle(myText: 'Home delivery', mySize: 14),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: Deliverytype.name3,
                        groupValue: _value,
                        onChanged: (Deliverytype? val) {
                          setState(() {
                            _value = val!;
                          });
                        }),
                    kTextstyle(myText: 'Take away', mySize: 14),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kTextstyle(
                    myText: 'Add more', mySize: 14, myWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              widget.counter--;
                              if (widget.counter <= 0) {
                                widget.counter = 0;
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
                              myText: widget.counter.toString(), mySize: 16),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              widget.counter++;
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
                              child: Icon(Icons.add))),
                    ],
                  ),
                ),
              ],
            ),
            // kTextstyle(
            //     myText: 'Calender', mySize: 16, myWeight: FontWeight.w600),
            SizedBox(
              height: 28,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kredColor),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    kTextstyle(
                        myText: 'Order now',
                        mySize: 14,
                        myWeight: FontWeight.w600),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class FinalOrderCard extends StatefulWidget {
  final String image;
  final String productname;
  final String price;
  final String? qty;


  const FinalOrderCard({Key? key,required this.image,required this.productname,required this.price,required this.qty,}) : super(key: key);

  @override
  State<FinalOrderCard> createState() => _FinalOrderCardState();
}

class _FinalOrderCardState extends State<FinalOrderCard> {
  late int counter =1;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<NewCartProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: kgreyColor?.withOpacity(0.018),
          // borderRadius: BorderRadius.circular(0),
          border: Border.symmetric(
              horizontal:
              BorderSide(width: 1, color: klightgreyColor.withOpacity(0.12)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  color: kwhiteColor,
                  image: DecorationImage(image: NetworkImage(widget.image),fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8)
              ),),
            SizedBox(width: 24,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kTextstyle(myText: widget.productname,mySize: 16,myWeight: FontWeight.w600,myColor: kgreyColor),
                  Row(
                    children: [
                      Icon(Icons.currency_rupee,size: 16,color:Colors.red.shade700,),
                      kTextstyle(myText: widget.price,mySize: 14,myWeight: FontWeight.w600,myColor:Colors.red.shade700),
                      InkWell(
                          onTap: () {
                            setState(() {
                              counter--;
                              if (counter <= 0) {
                                counter = 0;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: kwhiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: kblackcolor.withOpacity(0.15),
                                          offset: Offset(0, 1),
                                          blurRadius: 3)
                                    ],
                                    shape: BoxShape.circle),
                                child: Icon(Icons.remove)),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                          child: kTextstyle(
                              myText:
                              // widget.qty!
                              "$counter"
                              , mySize: 14),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              counter++;
                            });
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: kwhiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: kblackcolor.withOpacity(0.15),
                                        offset: Offset(0, 1),
                                        blurRadius: 3)
                                  ],
                                  shape: BoxShape.circle),
                              child: Icon(Icons.add))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: kTextstyle(myText: widget.price,mySize: 14,myWeight: FontWeight.w600,myColor:Colors.red.shade700),
                      ),
                    ],),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

/// ============================== home_page  ======= all kitchen  ====================


class KitchenCard extends StatefulWidget {
  final String oimage;
  final String oname;
  final String odelivery;
  final String About;
   final String distance;
  // final String distance;
  // final String onavi;
  // final String time;

  const KitchenCard(
      {Key? key,
        required this.odelivery,
        // required this.time,
        required this.oimage,
        required this.oname,
        required this.About,
        // required this.onavi,
        required this.distance,
      })
      : super(key: key);

  @override
  State<KitchenCard> createState() => _KitchenCardState();
}

class _KitchenCardState extends State<KitchenCard> {
  bool fav = true;



  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 16, left: 18, right: 12, bottom: 16),
      height: 112,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Color(0xffDADADA)),
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.08),
                blurRadius: 2,
                offset: Offset(0, 4))
          ]),
      child: SizedBox(
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Container(
              height: double.maxFinite,
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(widget.oimage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.asset(,width: 108,height: double.maxFinite,fit: BoxFit.cover,),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Flexible(child: Text(widget.oname, style: TextStyle(fontSize: 12),)),
                  Flexible(
                      flex: 1,
                      child: kTextstyle(
                          myText: widget.oname,
                          mySize: 14,space: 0.4,
                          myWeight: FontWeight.w600)),

                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 14,
                        color: kgreenColor,
                      ),
                      kTextstyle(
                          myText: " ${widget.odelivery}",
                          mySize: 12,
                          myColor: kgreyColor,
                          myWeight: FontWeight.w600),
                      kTextstyle(
                        myText: ' min',
                        mySize: 12,
                        myColor: kgreyColor!.withOpacity(0.9),
                      ),
                      // kTextstyle(myText:  widget.distance,mySize: 12,lines: 2),

                      SizedBox(width: 18,),
                      Row(
                        children: [
                          kTextstyle(myText: "4.2  ",mySize: 12,myWeight: FontWeight.w600),
                          Icon(FontAwesome.star,size: 12,color: kgreyColor!.withOpacity(0.7),)
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      kTextstyle(
                          myText: "distance :",
                          mySize: 12,
                          myColor: Colors.black),
                      SizedBox(
                        width: 4,
                      ),
                      kTextstyle(
                          myText: widget.distance,
                          mySize: 12,
                          myColor: Colors.black),
                      kTextstyle(
                          myText: '  km',
                          mySize: 12,
                          myColor: Colors.black,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  kTextstyle(myText:  widget.About,mySize: 12,lines: 2),

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: (){
                //
                //     setState(() {
                //
                //       fav = false;
                //
                //     });
                //     toast(fav);
                //
                //   },
                //   icon :  Icon((fav = true )? Icons.favorite_outline : Icons.favorite ),iconSize: 16,
                // ),

                /// non veg mark
                // Container(
                //     height: 18,
                //     width: 18,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: kredColor, width: 2)),
                //     child: Icon(
                //       Icons.circle,
                //       size: 10,
                //       color: Colors.red,
                //     ))
                // Icon(Icons.favorite, size: 16, ),
                // Icon(Icons.share, size: 16,),
                // Icon(Icons.more_vert_sharp, size: 16,)
                // IconButton(
                //     onPressed: (){
                //       Navigator.pushNamed(context, MyRoutes.SharePage);
                //     }, icon: Icon(Icons.share,size: 12,)),
                //   IconButton(
                //       onPressed: (){
                //         Navigator.pushNamed(context, MyRoutes.SharePage);
                //       }, icon: Icon(Icons.share,size: 12,))
              ],
            )
          ],
        ),
      ),
    );
  }
}






class GreyKitchenCard extends StatefulWidget {
  final String oimage;
  final String oname;
  final String odelivery;
  final String About;
   final String distance;
  // final String distance;
  // final String onavi;
  // final String time;

  const GreyKitchenCard(
      {Key? key,
        required this.odelivery,
        // required this.time,
        required this.oimage,
        required this.oname,
        required this.About,
        // required this.onavi,
         required this.distance
      })
      : super(key: key);

  @override
  State<GreyKitchenCard> createState() => _GreyKitchenCardState();
}

class _GreyKitchenCardState extends State<GreyKitchenCard> {
  bool fav = true;



  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 16, left: 18, right: 12, bottom: 16),
      height: 112,
      decoration: BoxDecoration(
        color: klightgreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        // image: DecorationImage(image: AssetImage("assets/images/closed.png")),
        border: Border.all(width: 1, color: Color(0xffDADADA)),
      ),
      child: SizedBox(
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Container(
              height: double.maxFinite,
              width: 98,
              child: Container(width: 42,height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                  color: kgreyColor!.withOpacity(0.3),
                ),
                child: kTextstyle(myColor: kwhiteColor,lines:2,myText: "closed for now",myDirection: TextAlign.center,mySize: 14,myWeight: FontWeight.w600),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: NetworkImage(widget.oimage),
                    fit: BoxFit.cover,colorFilter: ColorFilter.mode(kgreyColor!.withOpacity(0.2), BlendMode.multiply)
                ),
              ),
            ),
            // Image.asset(,width: 108,height: double.maxFinite,fit: BoxFit.cover,),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  // Flexible(child: Text(widget.oname, style: TextStyle(fontSize: 12),)),
                  Flexible(
                      flex: 1,
                      child: kTextstyle(
                          myText: widget.oname,
                          mySize: 14,space: 0.4,
                          myColor: kgreyColor!.withOpacity(0.8),
                          myWeight: FontWeight.w600)),

                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 14,
                        color: kgreenColor,
                      ),
                      kTextstyle(
                          myText: " ${widget.odelivery}",
                          mySize: 12,
                          myColor: kgreyColor!.withOpacity(0.8),
                          myWeight: FontWeight.w600),
                      kTextstyle(
                        myText: ' min',
                        mySize: 12,
                        myColor: kgreyColor!.withOpacity(0.9),
                      ),
                      SizedBox(width: 18,),
                      Row(
                        children: [
                          kTextstyle(myText: "4.2  ",mySize: 12,myColor: kgreyColor!.withOpacity(0.8),myWeight: FontWeight.w600),
                          Icon(FontAwesome.star,size: 12,color: kgreyColor!.withOpacity(0.7),)
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      kTextstyle(
                          myText: "distance :",
                          mySize: 12,
                          myColor: Colors.black),
                      SizedBox(
                        width: 4,
                      ),
                      kTextstyle(
                          myText: widget.distance,
                          mySize: 12,
                          myColor: Colors.black),
                      kTextstyle(
                          myText: '  km',
                          mySize: 12,
                          myColor: Colors.black,
                          myWeight: FontWeight.w600),
                    ],
                  ),
                  kTextstyle(myText:  widget.About,mySize: 12,myColor: kgreyColor!.withOpacity(0.8),lines: 2)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // IconButton(
                //   onPressed: (){
                //
                //     setState(() {
                //
                //       fav = false;
                //
                //     });
                //     toast(fav);
                //
                //   },
                //   icon :  Icon((fav = true )? Icons.favorite_outline : Icons.favorite ),iconSize: 16,
                // ),

                /// non veg mark
                // Container(
                //     height: 18,
                //     width: 18,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: kredColor, width: 2)),
                //     child: Icon(
                //       Icons.circle,
                //       size: 10,
                //       color: Colors.red,
                //     ))
                // Icon(Icons.favorite, size: 16, ),
                // Icon(Icons.share, size: 16,),
                // Icon(Icons.more_vert_sharp, size: 16,)
                // IconButton(
                //     onPressed: (){
                //       Navigator.pushNamed(context, MyRoutes.SharePage);
                //     }, icon: Icon(Icons.share,size: 12,)),
                //   IconButton(
                //       onPressed: (){
                //         Navigator.pushNamed(context, MyRoutes.SharePage);
                //       }, icon: Icon(Icons.share,size: 12,))
              ],
            )
          ],
        ),
      ),
    );
  }
}

