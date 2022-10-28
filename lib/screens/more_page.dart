import 'dart:convert';

import 'package:cloud_tiffin/screens/about_us_page.dart';
import 'package:cloud_tiffin/screens/contact_us_page.dart';
import 'package:cloud_tiffin/screens/edit_profile_page.dart';
import 'package:cloud_tiffin/screens/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../helper/colors.dart';
import '../helper/theme.dart';

class MorePAge extends StatefulWidget {
  const MorePAge({Key? key}) : super(key: key);

  @override
  _MorePAgeState createState() => _MorePAgeState();
}

class _MorePAgeState extends State<MorePAge> {
  String? name;
  String? email;
  bool? isLoading = false;
  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.cloudtiffin.cloudtiffin",
        subject: "playstore app link",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  String? phone;
  List Ticon = [
    Icon(
      Icons.notifications_active,
      color: kgreenColor.withOpacity(0.8),
    ),
    Icon(
      Icons.account_box,
      color: kgreenColor.withOpacity(0.8),
    ),
    Icon(
      Icons.call,
      color: kgreenColor.withOpacity(0.8),
    ),
  ];
  List Tname = [
    'Notifications',
    'Share',
    'Contact Us',
  ];

  @override
  void initState() {
    super.initState();
    _get_session();
    getProfile();
  }

  Future<void> getProfile() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    String? user_id = prefs.getString('id');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/user_profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': '$user_id',
      }),
    );

    final data = json.decode(response.body);
    print(data);
    final List responseBody = data['profileinfo'];
    print(responseBody);
    setState(() {
      isLoading = false;
    });
    for (var i in responseBody) {
      print(i['name']);
      setState(() {
        name = i['name'];
        email = i['email'];
        phone = i['phone_no'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();

    phone = prefs.getString('phone');
    print("hello $phone");
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return OverlaySupport.global(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screen.height * 0.28,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(74),
                      bottomRight: Radius.circular(0)),
                  color: kgreenColor.withOpacity(0.12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     blurRadius: 4,
                  //     offset: Offset(
                  //       0,3
                  //     )
                  //   )
                  // ]
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Center(
                        child: Image.asset(
                      'assets/images/logo.png',
                      height: 86,
                      width: 144,
                    )),
                    // SizedBox(height: 24,),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   foregroundImage:
                          // )
                          Container(
                            width: 56,
                            height: 53,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/logo.png')),
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.16),
                                      blurRadius: 12,
                                      offset: const Offset(0, 0))
                                ]),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kTextstyle(
                                  mySize: 16,
                                  myText: "$name",
                                  myWeight: FontWeight.w600),
                              kTextstyle(
                                  mySize: 14,
                                  myText: "+91 $phone",
                                  myWeight: FontWeight.w500,
                                  myColor: Colors.grey.withOpacity(0.8)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              ///===================================================================================
              InkWell(
                onTap: () {
                  Get.to(() => EditProfilePage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: kredColor.withOpacity(0.1), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.account_box,
                          color: kgreenColor.withOpacity(0.8),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: kTextstyle(
                                myText: 'My Profile',
                                mySize: 16,
                                myWeight: FontWeight.w600,
                                myColor: kgreyColor)),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kgreenColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //==================================================================
              InkWell(
                onTap: () {
                  Get.to(() => const NotificationPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: kredColor.withOpacity(0.1), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.notifications_active,
                          color: kgreenColor.withOpacity(0.8),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: kTextstyle(
                                myText: 'Notification',
                                mySize: 16,
                                myWeight: FontWeight.w600,
                                myColor: kgreyColor)),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kgreenColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //=====================================================
              InkWell(
                onTap: () {
                  Share.share(
                      "Hey Check out this new app https://play.google.com/store/apps/details?id=com.cloudtiffin.cloud_tiffin");
                  // Get.offAll(() => onShare);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: kredColor.withOpacity(0.1), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.share_sharp,
                          color: kgreenColor.withOpacity(0.8),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: kTextstyle(
                                myText: 'Share',
                                mySize: 16,
                                myWeight: FontWeight.w600,
                                myColor: kgreyColor)),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kgreenColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // KitchenController newKictechnController = Get.find(tag: "product1");
                  // print(newKictechnController.price.value);

                  Get.to(() => const ContactUsPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: kredColor.withOpacity(0.1), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.email,
                          color: kgreenColor.withOpacity(0.8),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: kTextstyle(
                                myText: 'Contact Us',
                                mySize: 16,
                                myColor: kgreyColor,
                                myWeight: FontWeight.w600)),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kgreenColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Get.to(()=> SignupProfilePage());
                  Get.to(() => const AboutUsPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: kredColor.withOpacity(0.1), width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: kgreenColor.withOpacity(0.8),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: kTextstyle(
                                myText: 'About Us',
                                myColor: kgreyColor,
                                mySize: 16,
                                myWeight: FontWeight.w600)),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kgreenColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 98,
              ),

              InkWell(
                onTap: () {
                  logout();
                },
                child: Container(
                  height: 42,
                  width: 124,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue.shade800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      kTextstyle(
                          myColor: Colors.white,
                          mySize: 14,
                          myText: 'Logout',
                          myWeight: FontWeight.w600),
                    ],
                  ),
                ),
              )
              // ElevatedButton(
              //     onPressed: () {
              //
              //     },
              //
              //     style: ElevatedButton.styleFrom(
              //       onSurface: kredColor,
              //       onPrimary: kredColor,
              //       minimumSize: Size(108, 36),
              //       maximumSize: Size(124, 48),
              //       primary: Colors.grey[200],
              //       // shadowColor: Colors.red,
              //     ),
              //     child:)
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/');
  }
}
