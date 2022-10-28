import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:flutter/material.dart';

import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:http/http.dart' as http;
import '../config.dart';
import '../helper/theme.dart';
import '../model/completed_model.dart';
import '../screens/review_page.dart';

class CompletedOrderCard extends StatefulWidget {
  final CompletedModel? completedlists;

  const CompletedOrderCard({Key? key, this.completedlists}) : super(key: key);

  @override
  State<CompletedOrderCard> createState() => _CompletedOrderCardState();
}

class _CompletedOrderCardState extends State<CompletedOrderCard> {
  double rating =0;
  TextEditingController reviewController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print('Hello sub array ${widget.completedlists!.user_details[0]}');
    return Container(
      width: screen.width(context),
      margin: EdgeInsets.only( left: 18.0, right: 18.0,top:15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kgreyColor!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screen.width(context),
            height: 35.0,
            decoration: BoxDecoration(
              color: kredColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: Center(
                child: Text('Completed',

                    style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)
                        .copyWith(color: kwhiteColor))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.completedlists!.user_details[0]['shop_image']!,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),

                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      SizedBox(height: 8.0),
                      Text("Kitchen Provider : ${widget.completedlists!.user_details[0]['shop_name']}",
                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                      SizedBox(height: 8.0),
                      Text("Address : ${widget.completedlists!.user_details[0]['shop_address']}",
                          style: GoogleFonts.poppins(fontSize: 12,color: kgreyColor,)),
                      SizedBox(height: 8.0),
                      Text("Order Id : ${widget.completedlists!.order_id}",
                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.4)),
                      SizedBox(height: 8.0),
                      Text("Order Date : ${widget.completedlists!.created_at}",
                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.4)),
                      SizedBox(height: 8.0),
                      // Text(
                      //     '${pendinglists!.schedule_date} - ${pendinglists!.schedule_time}',
                      //     style: theme.textTheme.subtitle2),
                      //SizedBox(height: 8.0),

                      // SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(

                            children:widget.completedlists!.products
                                .map(
                                  (e) => Column(

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      Text(e['name'],maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8,)),
                                      SizedBox(width: 15.0),

                                      Text("${e['qty']}",
                                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                                      SizedBox(height: 15.0),
                                      Text(" X ${e['price']}",
                                          style: theme.textTheme.bodyText2!.copyWith(
                                              color: theme.unselectedWidgetColor)),
                                      SizedBox(height: 15.0),
                                      // Text("\u{20B9}${e['total_price']}",
                                      //     style: theme.textTheme.headline6!.copyWith(
                                      //         color: theme.unselectedWidgetColor)),
                                    ],
                                  ),

                                ],
                              ),
                            )
                                .toList(),
                          ),
                          SizedBox(height: 15.0),
                          // SmoothStarRating(
                          //   color: kYellowColor,
                          //   size: 17.0,
                          //   borderColor: theme.unselectedWidgetColor,
                          //   allowHalfRating: false,
                          //   rating: 4,
                          //   starCount: 5,
                          //   isReadOnly: true,
                          // ),
                          // completedlists!.status == "COMPLETED"
                          //     ? Container()
                          //     : completedlists!.status == "CANCEL"
                          //     ? Container()
                          //     : GestureDetector(
                          //   onTap: () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           title:  kTextstyle(myText: "Cancel Order!",mySize: 16,myWeight: FontWeight.w600,myColor: kgreyColor
                          //           ),
                          //           content:  kTextstyle(myText: "Are you sure to cancel order?",mySize: 14,myColor: kgreyColor
                          //           ),
                          //           actions: [
                          //             TextButton(
                          //               onPressed: () {
                          //                 Get.back();
                          //               },
                          //               child:  kTextstyle(myText: "No",mySize: 14,myColor: kgreyColor
                          //               ),
                          //             ),
                          //             TextButton(
                          //               onPressed: () {
                          //                 // (context);
                          //
                          //                 // Get.back();
                          //               },
                          //               child: Text('Yes',
                          //                   textAlign:
                          //                   TextAlign.center,
                          //                   style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   },
                          //   child: Row(
                          //     crossAxisAlignment:
                          //     CrossAxisAlignment.start,
                          //     children: [
                          //       Icon(
                          //         Icons.clear,
                          //         color: theme.errorColor,
                          //         size: 17.0,
                          //       ),
                          //       Text(
                          //
                          //           'Cancel Order',
                          //           style: GoogleFonts.poppins(fontSize: 12,color: kredColor,letterSpacing: 0.8))
                          //
                          //     ],
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(color: kgreyColor),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \u{20B9}${widget.completedlists!.price}',
                    style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                // GestureDetector(
                //     onTap: () {
                //       _asyncInputDialog(context,widget.completedlists!.id);
                //       // Get.to(
                //       //  PendingOrderDetailPage(pendinglists: pendinglists));
                //     },
                //     child: Text('Add Review',
                //         style: theme.textTheme.subtitle1!
                //             .copyWith(color: kredColor))),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _asyncInputDialog(BuildContext context,String? order_id) async {

    showDialog(
      context: context,


      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return AlertDialog(

          title: Center(child: Text("Post Review ", style: theme.textTheme.subtitle1!
              .copyWith(color: kredColor))),
          content: Container(
            // decoration: BoxDecoration(
            //   color: theme.cardColor,
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/other/backdes.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            height:120,
            child: Column(
              children: <Widget>[
                SizedBox(height: 12.0),
                SmoothStarRating(

                  color: Colors.yellow,
                  size: 47.0,
                  onRatingChanged: (v) {
                    // setState(() {
                    rating=v;
                    // });
                     },
                  borderColor: theme.unselectedWidgetColor,
                  allowHalfRating: false,
                  rating: rating,
                  starCount: 5,
                  // isReadOnly: false,
                ),
                SizedBox(height: 22.0),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    cursorColor: theme.primaryColor,
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                      hintStyle: theme.textTheme.subtitle2,
                    ),
                  ),
                ),
                //  Text("Please wait, while our freelancer accept your booking",style: theme.textTheme.headline3),


              ],
            ),
          ),
          actions: <Widget>[

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kredColor,
                foregroundColor: Colors.white,
              ),
              // color:  kredColor,
              // textColor: Colors.white,
              child: Text('POST'),
              onPressed: () {

                postNow(order_id,rating,reviewController.text);

                Navigator.pop(context);
                // Get.to(
                // AppointmentPage(),
                // MyBookingPage(),
                //Homepage(),

                // );

              },
            ),
          ],
        );
      },
    );
  }

  Future postNow(String? order_id,double rating,String? review) async{
    //await  Future.delayed(const Duration(seconds: 2));


    // setState(() {
    //   isLoading = true;
    // });



    // addressController.clear();





    var response = await  http.post(
      Uri.parse('${Config.BASEURL}user/add_review'),
      // Uri.parse('https://thesoftwareplanet.com/aayra/flutter_api/user/fiverbookService'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'order_id': "$order_id",
        'rating':'$rating',
        'review':'$review'


      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if(data['ResponseCode'] == '200')
    {
      // setState(() {
      //   isLoading = false;
      // });
      setState(() {
        reviewController.text="";
      });
      //toast(data['ResponseMsg']);



      // Navigate to Home & Sending Email to Next Screen.
      // Get.offAll(
      //   Homepage(),
      //
      // );
      //Navigator.pushNamed(context, '/HomePage');
    }else{

      // EasyLoading.showError('Invalid Credentials');
     // toast(data['ResponseMsg']);

      // setState(() {
      //   isLoading = false;
      // });


    }

  }
}

