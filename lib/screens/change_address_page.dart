import 'dart:convert';

// import 'package:blossom/screens/nearby_page.dart';
import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:cloud_tiffin/screens/Login_Page.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'nearby_page.dart';

class ChangeAddressPage extends StatefulWidget {
  @override
  State<ChangeAddressPage> createState() => _ChangeAddressPageState();
}

class _ChangeAddressPageState extends State<ChangeAddressPage> {
  final _controller = TextEditingController();

  //GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();

  String? _sessionToken;
  late List<Location> locations;
  List<dynamic> _placeList = [];
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM";
    String type = 'india';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // var response = await  http.get(Uri.parse('https://easemysalon.info/flutter_api/user/bestsalon_list'));

    String? request =
        '$baseURL?input=$input&components=country:IN&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    print(response);
    if (response.statusCode == 200) {
      // final query = "1600 Amphiteatre Parkway, Mountain View";

      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
      locations = await locationFromAddress("$_placeList");
      // var addresses = await Geocoder.local.findAddressesFromQuery(_placeList);
      // var first = addresses.first;
      locations.first.latitude;
      print("hello ${locations.first.latitude} : ${locations.first.longitude}");
      // print("${first.featureName} : ${first.coordinates}");
      setState(() {
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
      });
// From coordinates

    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final changeProv = Provider.of<ChangePasswordProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          backgroundColor: kredColor,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 32,
          shadowColor: Colors.white.withOpacity(0.25),
          foregroundColor: kblackcolor,
          leading: new IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    // BoxShadow(
                    //     color: kblackcolor.withOpacity(0.09),
                    //     offset: Offset(0, 2),
                    //     blurRadius: 4)
                  ],
                  border: Border.all(
                      width: 0.8, color: Colors.grey.withOpacity(0.2))),
              child: TextFormField(
                controller: _controller,
                key: _formKey,
                // validator: changeProv.validateAddress,
                onChanged: (val) {
                  // changeProv.onSavedAddress(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 12, top: 6),
                  border: InputBorder.none,
                  hintText: "Seek your location here",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                  focusColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ),
          ),

          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.close),
          //     onPressed: () {
          //       Get.back();
          //     },
          //   )
          // ],
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   color: theme.cardColor,
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/other/backdes.png"),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 12.0),
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //         borderRadius: BorderRadius.circular(38),
              //         boxShadow: [BoxShadow(color: kblackcolor.withOpacity(0.2),
              //         offset: Offset(0,2),
              //           blurRadius: 4
              //         )],
              //         border: Border.all(width: 0.8, color: Colors.grey.withOpacity(0.2))),
              //     child: TextFormField(
              //       controller: _controller,
              //       key: _formKey,
              //       // validator: changeProv.validateAddress,
              //       onChanged: (val) {
              //         // changeProv.onSavedAddress(val);
              //       },
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: "Seek your location here",
              //         hintStyle: GoogleFonts.poppins(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w500,
              //             color: Colors.grey),
              //         focusColor: Colors.white,
              //         focusedBorder: InputBorder.none,
              //         floatingLabelBehavior: FloatingLabelBehavior.never,
              //         prefixIcon: Icon(Icons.location_on_outlined),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 12.0),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _controller.text = _placeList[index]["description"];
                      });
                    },
                    child: Container(
                      width: double.maxFinite,
                      // padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.1)))),

                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        child: kTextstyle(
                            space: 0.4,
                            myText: _placeList[index]["description"],
                            mySize: 14),
                      ),
                    ),
                  );
                },
              ),
              // Text(
              //   'Change your address',
              //   style: theme.textTheme.subtitle2,
              // ),
              // SizedBox(height: 12.0),
              // TextFormField(
              //   controller: _controller,
              //   validator: changeProv.validateAddress,
              //   onChanged: (val) {
              //     changeProv.onSavedAddress(val);
              //   },
              //   obscureText: changeProv.obscureText,
              //   decoration: InputDecoration(
              //     hintText: 'Address',
              //   ),
              // ),
              // SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
//                  title: 'Change',
        onPressed: () {
          //if (_formKey.currentState!.validate()) {
          // changeProv.formKey.currentState!.save();
          //changeProv.autoValidate = false;
          // Get.to(()=> LoginPage());
          ///propper
          setUserData(_controller.text);

          // Get.offAll(BottomNavigationBarPage());
          // toast('Your address successfully changed');
          // }
          // else {
          //   changeProv.autoValidate = true;
          // }
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.blue[800],
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            minimumSize: Size(108, 42)),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Next',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
      ),
      //      FloatingActionButton(
      //   onPressed: () {},
      //   child:
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> setUserData(String address) async {
    final prefs = await SharedPreferences.getInstance();
    var data =  await locationFromAddress("$address");
   // var addresses = await Geocoder.local.findAddressesFromQuery(address);

   // var first = addresses.first;

    print("yd $data");

    print(" ${data.first.latitude},${data.first.longitude}");
    // print("${first.featureName} : ${first.coordinates.latitude},${first.coordinates.longitude}");

    // final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('location_lat', data.first.latitude);
    prefs.setDouble('location_long', data.first.longitude);
    prefs.setDouble('latitude', data.first.latitude);
    prefs.setDouble('longitude', data.first.longitude);



    prefs.setString("address", address);
    Get.offAll(() => BotNav());
    // Get.offAll(() => BotNav(), arguments: [
    //   {'latitude': '${latitude}'
    //   },
    //   {'longitude': '${longitude}'},
    //   {'address': address}
    // ]);
  }
}