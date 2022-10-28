import 'package:badges/badges.dart';
import 'package:cloud_tiffin/provider/new_cart_provider.dart';

import 'package:cloud_tiffin/screens/change_address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import 'package:food_app/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/cart_provider.dart';
import 'colors.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    headline1: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headline2: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headline3: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headline4: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    headline5: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.poppins(
      color: kblackcolor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    // headline1: GoogleFonts.poppins(
    //   color: kblackcolor,
    //   fontSize: 18,
    //   fontWeight: FontWeight.w700,
    // ),
  ));
}

/// appbar

/// custom text
var kTextstyle = (
        {final double? mySize,
        final double? space,
        // final double? wordspace,
        var myWeight,
        var myColor,
        required String myText,
        myDirection,
        lines}) =>
    Text(
      myText,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          // wordSpacing: wordspace ,
          letterSpacing: space,
          fontSize: mySize,
          fontWeight: myWeight,
          color: myColor),
      textAlign: myDirection,
    );
dynamic getarguments = Get.arguments;

CAppBar() {


  return PreferredSize(
    preferredSize: Size.fromHeight(56),
    child: AppBar(
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
                  SizedBox(
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
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: kTextstyle(
                    myText: "${Get.arguments[2]['address']}",
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
            //Get.to(CartListPage());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Badge(
                showBadge: true,
                position: BadgePosition.topStart(top: -8, start: 12),
                elevation: 0,
                borderSide: BorderSide(color: Colors.white, width: 2),
                badgeColor: Colors.red,
                badgeContent:
                    Consumer<NewCartProvider>(builder: (context, value, child) {
                  return Text('0',
                    // value.getCounter().toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: kwhiteColor,
                    ),
                  );
                }),
                child: Icon(
                  Icons.shopping_cart,
                  size: 28,
                  color: kgreyColor,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
bool checkAvailable(String? open , String? close) {
  ///CURRENT TIME
  String Timenow = DateFormat.H().format(DateTime.now());
  // String? hour = Timenow.substring(3);
  // String? PTime = Timenow.substring(0,2);
  // String? PTim =(' ${Timenow.substring(0,2)}' +' '+ '${Timenow.substring(6)}');
  // String? PTAMPM = Timenow.substring(6);

  ///INPUT OPEN CLOSE TIME
  String? OpenT = open!.substring(0, 3);
  String? CloseT = close!.substring(0, 3);
  String? OAMPM = open.substring(3);
  String? CAMPM = close.substring(3);
  int OT;
  int CT;
  int PT = int.parse(Timenow);
  print('present time  $PT');

  ///open time
  print('sssssssss    open $OAMPM');
  if (OAMPM == 'AM') {
    OT = int.parse(OpenT);
  }
  else {
    if (int.parse(OpenT) == 12) {
      OT = 12;
      print('$OT  is 12 pm');
    }
    else {
      OT = int.parse(OpenT) + 12;
      print('hhhhhhhhhhhh  open $OT');
    }
  }

  /// close time
  print('pm $CAMPM');
  if (CAMPM == 'AM') {
    CT = int.parse(CloseT);
    print('hhhhhhhhhhhh  close $CT');
  } else {
    CT = int.parse(CloseT) + 12;
    print('hhhh close  $CT');
  }

  if (PT >= OT && PT < CT) {
    print('Open true');
    return true;
  } else {
    print('Open false');
    return false;
  }
}
  allTimeStatus(String? breako,String? breakc,String? luncho,String? lunchc,String? dinnero,String? dinnerc){
    if(checkAvailable(breako, breakc) == true || checkAvailable(luncho, lunchc) == true || checkAvailable(dinnero, dinnerc) == true) {
      print('allTime true ============================================================');
      return true;
    }

    else{
      print('falseeee ==================================================================');
      return false;
    }}

