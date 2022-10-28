import 'dart:async';
import 'dart:collection';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_tiffin/screens/ask_location_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login_Page.dart';

// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ));
//     return AnimatedSplashScreen(
//       splash: 'assets/images/other/Logo (2).png',
//       nextScreen: SplashWelcomePage(),
//       splashTransition: SplashTransition.fadeTransition,
//       pageTransitionType: PageTransitionType.fade,
//       duration: 3000,
//       centered: true,
//       animationDuration: Duration(milliseconds: 1500),
//     );
//   }
// }

class SplashPage extends StatefulWidget {
//class SplashWelcomePage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? phone;
  late double latitude;
  late double longitude;
  late BitmapDescriptor _markerIcon;
  Set<Marker> _markers = HashSet<Marker>();
  String? address;

  startTime() {
    Timer(
      Duration(milliseconds: 1000),
      () {
        if(phone == null) {
          Get.to(()=>
            // SigninWithPhonePage()
              LoginPage()
            //SignInWithSocialMediaPage()
          );
        }else {
          Get.to(()=>
              AskLocationScreen()
            //     NearbyPage(),arguments: [
            //   {'latitude':'${latitude}'}, {'longitude':'${longitude}'},{'address':'${address }'}
            // ]
          );
        }
        // BottomNavigationBarPage(),

        // }
        // Get.to(
        //   LoginPage()
        //   //SigninWithPhonePage()
        //   // AskLocationScreen(),
        //   //SignInWithSocialMediaPage()
        // );
        // Get.offAll(
        //  OnBoardingPage(),
        //  //SignInWithEmailPage(),
        // );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _get_session();

    // _autoGetLocation().whenComplete(() {
    //   setState(() {
    //     // latitude = Get.arguments[0]['latitude'];
    //     // longitude = Get.arguments[1]['longitude'];
    //   });
    // });
    _autoGetLocation();
    startTime();
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
  }

  _autoGetLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    debugPrint('location: ${position.latitude},${position.longitude}');
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // final coordinates = new Coordinates(position.latitude, position.longitude);

    // var addresses =  await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Placemark placeMark = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    address = "$name, $subLocality, $locality";

    setState(() {
      // latitude  = position.latitude;
      // longitude = position.longitude;
      address = "$name, $subLocality, $locality";
    });
    print('$address');

    // setState(() {
    //   address = "$name";
    //  // address = "$name + $subLocality + $locality";
    //   //_setMarkerIcon();
    // });
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/marker.png');
  }
  Future<void> requestPermission() async {
    await Permission.location.request();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fitWidth,
        )),
      ),
    );
  }
}
