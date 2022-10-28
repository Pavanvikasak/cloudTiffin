import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_tiffin/config.dart';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:cloud_tiffin/screens/direction_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:shared_preferences/shared_preferences.dart';



import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../model/accepted_model.dart';
import '../screens/ChatPage.dart';
import '../screens/bottom_navigation.dart';


class AcceptedOrderCard extends StatefulWidget {
  final AcceptedModel? acceptedlists;

  const AcceptedOrderCard({Key? key, this.acceptedlists}) : super(key: key);

  @override
  State<AcceptedOrderCard> createState() => _AcceptedOrderCardState();
}

class _AcceptedOrderCardState extends State<AcceptedOrderCard> {
  double? latitude;
 double? longitude;

 void initState() {
   super.initState();
   _get_session();
 }
  Future<void> _get_session() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
    });



  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print('Hello sub array ${widget.acceptedlists!.user_details[0]}');

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
                child: Text('Accepted',

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
                    imageUrl: widget.acceptedlists!.user_details[0]['shop_image']!,
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
                      Text("Kitchen Provider : ${widget.acceptedlists!.user_details[0]['shop_name']}",
                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                      SizedBox(height: 8.0),
                      Text("Address : ${widget.acceptedlists!.user_details[0]['shop_address']}",
                          style: GoogleFonts.poppins(fontSize: 12,color: kgreyColor,)),
                      SizedBox(height: 8.0),
                      Text("Order Id : ${widget.acceptedlists!.order_id}",
                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.4)),
                      SizedBox(height: 8.0),
                      Text("Delivery otp : ${widget.acceptedlists!.otp}",
                          style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.4)),
                      SizedBox(height: 8.0),
                      Text("Order Date : ${widget.acceptedlists!.created_at}",
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

                            children:widget.acceptedlists!.products
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
                          /// ===================================== cancel button
                          GestureDetector(
                              onTap: () {
                                Get.to(
                                    ChatUiPage(), arguments: [
                                  {'order_id': '${widget.acceptedlists!.order_id}'},
                                  {'name': '${widget.acceptedlists!.user_details[0]['shop_name']}'},
                                  {'vendor_id': '${widget.acceptedlists!.user_details[0]['id']}'}

                                ]
                                );
                              },
                              child: Text('Chat',
                                  style: GoogleFonts.poppins(fontSize: 16,color: kredColor,letterSpacing: 0.8))),
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
                Text('Total: \u{20B9}${widget.acceptedlists!.price}',
                    style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: kgreyColor,letterSpacing: 0.8)),
                GestureDetector(
                    onTap: () {
                      _launchURL(widget.acceptedlists!.user_details[0]['shop_address']);
                  //     Get.to(
                  //         DirectionPage(), arguments: [
                  // {"id": "${widget.acceptedlists!.user_details[0]['id']}"},
                  //       {'shop_name': '${widget.acceptedlists!.user_details[0]['shop_name']}'},
                  //
                  //     ]
                  //     );
                    },
                    child: Text('Direction',
                        style: GoogleFonts.poppins(fontSize: 16,color: kredColor,letterSpacing: 0.8))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String address) async {
   print(address);
     const String destLat = "22.0690175";
     const String destLng = "81.6923472";
   // double?  destLat = 22.0690175;
   //  double? destLng=  81.6923472;
    //const url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$latitude,$longitude&destinations=$destLat,$destLng&key=AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM'));
     final url = 'http://maps.google.com/maps?daddr=${Uri.encodeFull(address)}&directionsmode=driving';

  //   const url = 'http://maps.google.com/maps?daddr=$destLat,$destLng';
   // const url ='https://www.google.com/maps/dir/?api=1&origin=$homeLat,$homeLng&destination=43.5184049,-79.8473993&dir_action=navigate';
    // final String url = "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";

    if (await canLaunch(url)) {

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future CancelOrder(context) async{
    await  Future.delayed(const Duration(seconds: 2));
    //  await EasyLoading.show(
    //    status: 'loading...',
    //    maskType: EasyLoadingMaskType.black,
    //  );
    //EasyLoading.show();
    final prefs = await SharedPreferences.getInstance();
    // Showing CircularProgressIndicator.





    String? user_id =  prefs.getString('id');

    var response = await  http.post(
      Uri.parse('${Config.BASEURL}user/cancel_booking_status'),
      // Uri.parse('https://thesoftwareplanet.com/blossom/flutter_api/user/cancel_booking_status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': "$user_id",
        'id': '${widget.acceptedlists!.id}',


      }),
    );
    //var response = await http.post(url, body: json.encode(data[email]));


    // Getting Server response into variable.
    var data = jsonDecode(response.body);
    print(data);

    // If the Response Message is Matched.
    if(data['ResponseCode'] == '200')
    {

      // var responseBody = data['user'];
      // print(responseBody);

      setState(() {});
      // toast(data['ResponseMsg']);
      //   Get.back();
      // Navigator.popAndPushNamed(context,'/AppointmentPage');
      // Navigator.pushNamed(context, '/AppointmentPage');
      // Navigate to Home & Sending Email to Next Screen.
      home();
    }else{
      // EasyLoading.showError('Invalid Credentials');
      toast(data['ResponseMsg']);



    }

  }
  Future home()  async {
    //await  Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();







    //toast(data['ResponseMsg']);
    double? lat =   prefs.getDouble('latitude');
    double? lng =    prefs.getDouble('longitude');
    String? address =  prefs.getString("address");

    // Navigate to Home & Sending Email to Next Screen.
    Get.offAll(
        BotNav(), arguments: [
      {'latitude': '${lat}'},
      {'longitude': '${lng}'},
      {'address': '${address}'}
    ]

    );





  }
}