import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/more_page.dart';
import 'package:cloud_tiffin/screens/offers_page.dart';
import 'package:cloud_tiffin/screens/order_page.dart';
import 'package:cloud_tiffin/screens/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';


import 'package:google_fonts/google_fonts.dart';

import '../helper/colors.dart';
import 'new_home_page.dart';

// import 'package:flutter_icons/flutter_icons.dart';

class BotNav extends StatefulWidget {
  const BotNav({Key? key}) : super(key: key);

  @override
  _BotNavState createState() => _BotNavState();
}
@override
class _BotNavState extends State<BotNav> {


  @override initState(){
    super.initState();

  }
  int _currentIndex = 0;
  final screens = const [NewHomePage(),AppointmentPage(),SearchPage(),OffersPage(), MorePAge()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            elevation: 2,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 22,
            backgroundColor: Colors.white,
            selectedItemColor: kredColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle:
            GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),
            unselectedLabelStyle:
            GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,

            items: [
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 0
                    ? Icons.home_rounded
                    : Icons.home_outlined),
                label: "HOME",
              ),
              BottomNavigationBarItem(

                icon: Icon(
                  _currentIndex == 1
                      ? FlutterIcons.shopping_bag_faw5s
                      : FlutterIcons.shopping_bag_faw5s,
                ),
                label: "ORDER",
              ),

              BottomNavigationBarItem(
                tooltip: 'search',
                icon: Icon(
                  Icons.error,color: Colors.transparent,),
                  label: '',),
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 3
                    ? Icons.discount
                    : Icons.discount_outlined),
                label: "OFFERS",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _currentIndex == 4 ? Icons.segment : Icons.segment_outlined,
                ),
                label: "MORE",
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 16,
            left: screen.width(context)*0.425,
            child: InkWell(
              onTap: (){
                 Get.to(()=>const SearchPage());
              },
              child: Container(alignment: Alignment.center,
                height: 56,
                width: 56,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color:kredColor,
                    border: Border.all(color: kredColor,width: 4),
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      offset: Offset(0,2),
                      spreadRadius: 4,
                      blurRadius: 6
                    )]
                    ),
                child: Icon(Icons.search,color: kwhiteColor,size: 32,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
