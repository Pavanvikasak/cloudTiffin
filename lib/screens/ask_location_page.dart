import 'dart:async';
import 'dart:io';


import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as locService;


import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

import 'change_address_page.dart';
import 'nearby_page.dart';

class AskLocationScreen extends StatefulWidget {
  const AskLocationScreen({Key? key}) : super(key: key);

  @override
  _AskLocationScreenState createState() => _AskLocationScreenState();
}

class _AskLocationScreenState extends State<AskLocationScreen> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? mobile_num;
  String? email;
  late double location_lat;
  late double location_long;
  double? latitude;
  double? longitude;
  String? address;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _requestPermission();
  }
  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
     // _requestPermission();
      exit(0);
    } else if (status.isPermanentlyDenied) {
    //  _requestPermission();
      exit(0);
   //   openAppSettings();
    }
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  mobile_num = prefs.getString('mobile_num');
    setState(() {
      email = prefs.getString('email');
      // location_lat = prefs.getDouble('latitude')!;
      // location_long = prefs.getDouble('longitude')!;
      address = prefs.getString('address');
    });
  }

  Future<void> setUserData(String address, Position position) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);
    prefs.setString("address", address);
    Timer(const Duration(seconds: 3), () {
      context.loaderOverlay.hide();
      Get.offAll(()=>BotNav()

      );

    });
  }

  String location = 'Null, Press Button';
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _showToast(BuildContext context, double lat, double long,
      List<Placemark> placemark) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('Location: $lat $long , Address: $placemark'),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return LoaderOverlay(
      child: //Scaffold(

          Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,

        ),
        alignment: Alignment.center,
        child: Center(
          child: Container(
            height: 410,
            child: Column(
              children: [
                Text("Hi, Nice to meet you!",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                Text("See Services Around You",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 5,
                ),
                const Image(
                    height: 212,
                    width: 300,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/location.png')),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: InkWell(
                    onTap: () async {
                      context.loaderOverlay.show();
                      Position position = await _getGeoLocationPosition();
                      // Timer(const Duration(seconds: 10), () {});
                      print(position);
                      print(position.latitude);
                      print(position.longitude);
                      location =
                          'Lat: ${position.latitude} , Long: ${position.longitude}';

                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              position.latitude, position.longitude);
                      print(placemarks);
                      Placemark place = placemarks[0];
                      String placeName = place.name.toString();
                      String placeStreet = place.street.toString();
                      String placeLocality = place.locality.toString();
                      String placePostalCode = place.postalCode.toString();
                      String placeSubAdministrativeArea =
                          place.subAdministrativeArea.toString();
                      String placeAdministrativeArea =
                          place.administrativeArea.toString();
                      String placeIsoCountryCode =
                          place.isoCountryCode.toString();
                      String placeContry = place.country.toString();

                      String address = placeName +
                          ", " +
                          // placeStreet +
                          // ", " +
                          placeLocality +
                          ", " +
                          // placePostalCode +
                          // ", " +
                          // placeSubAdministrativeArea +
                          // ", " +
                          placeAdministrativeArea +
                          ", " +
                          //placeIsoCountryCode + ", " +
                          placeContry;
                      print('address =>');
                      print(address);
                      setUserData(address, position);
                      //GetAddressFromLatLong(position);
                      // Timer(const Duration(seconds: 3), () {
                      //   context.loaderOverlay.hide();
                      //   Get.to(()=>BotNav()
                      //     //   , arguments: [
                      //     // {'latitude': '${position.latitude}'},
                      //     // {'longitude': '${position.longitude}'},
                      //     // {'address': '${address}'}
                      //  // ]
                      //   );
                      //   // Get.to(
                      //   //
                      //   //     NearbyPage()
                      //   //
                      //   // );
                      //   // Navigator.of(context).pushReplacement(
                      //   //     CustomPageRoute(child: const BottomNav()));
                      // });
                      // _showToast(context, position.latitude, position.longitude,
                      //     placemarks);
                    },
                    splashColor: const Color(0xFF9aa5b8),
                    child: Container(
                      height: 42,
                      width: screen.width(context) - 48,
                      decoration: BoxDecoration(
                        color: kredColor,
                        border: Border.all(
                          color: kredColor,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "My Current Location",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      Get.to(ChangeAddressPage());
                    },
                    splashColor: const Color(0xFF9aa5b8),
                    child: Container(
                      height: 42,
                      width: screen.width(context) - 48,
                      decoration: BoxDecoration(
                        color: const Color(0xffE3F1FF),
                        border: Border.all(
                          color: theme.primaryColor,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.search,
                              color: Color(0xFF1E1B1B),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Some Other location",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1E1B1B),
                                  fontSize: 14),
                            ),
                            // const SizedBox(
                            //   width: 15,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
