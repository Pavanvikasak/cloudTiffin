// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_tiffin/screens/search_page.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_icons/flutter_icons.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../config.dart';
// import '../provider/category_provider.dart';
// import 'change_address_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart' as loc;
//
// class NearbyPage extends StatefulWidget {
//   @override
//   _NearbyPageState createState() => _NearbyPageState();
// }
//
// class _NearbyPageState extends State<NearbyPage> {
//
//   final loc.Location location = loc.Location();
//   StreamSubscription<loc.LocationData>? _locationSubscription;
//   bool isLocation =false;
//   final databaseRef = FirebaseDatabase.instance.reference();
//   bool _switchValue=true;
//   bool _isList = false;
//   var Internetstatus = "Unknown";
//   bool isLoading =false;
//
//   var city = '';
//   var area = '';
//   var state = '';
//   var postcode = '';
//   var address = '';
//   var country = '';
//   var storeid = '1';
//   String email='';
//   String? name;
//   String? user_id;
//   var data = Get.arguments;
//
//   late List properties;
//   late double latitude;
//   late double longitude;
//   late Position currentPosition;
//   var geoLocator = Geolocator();
//   late BitmapDescriptor _markerIcon;
//   Set<Marker> _markers = HashSet<Marker>();
//   bool dialogShown = false;
//   List<Marker> nearbylist = [];
//
//   @override
//    initState()  {
//     super.initState();
//
//
//     // _autoGetLocation();
//     // _get_session();
//     _get_session().whenComplete((){
//       setState(() {
//
//       });
//     });
//       setState(() {
//
//
//         // latitude =  double.parse('22.0691357');
//         // longitude = double.parse('81.6937222');
//
//          latitude = double.parse(Get.arguments[0]['latitude']);
//          longitude = double.parse(Get.arguments[1]['longitude']);
//         address = Get.arguments[2]['address'];
//
//
//       });
//
//     _listenLocation();
//     print(data[0]['latitude']);
//     print(data[1]['longitude']);
//     print(data[2]['address']);
//     nearbyvendors();
//         // latitude = data[0]['latitude'];
//         //  longitude = data[1]['longitude'];
//         //  address = data[2]['address'];
//       // _autoGetLocation().whenComplete(() {
//       //   setState(() {
//       //     latitude = Get.arguments[0]['latitude'];
//       //     longitude = Get.arguments[1]['longitude'];
//       //   });
//       // });
//
//
//
//     // if (dialogShown == false) {
//     //   setState(() {
//     //     dialogShown = true;
//     //   });
//     //
//     //   Timer(const Duration(seconds: 3), () => {openDialog()});
//     // }
//     checkFirstSeen();
//    // user_id = Get.arguments[0]["location"];
//   }
//   Future checkFirstSeen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool _seen = (prefs.getBool('seen') ?? false);
//
//     if (_seen) {
//      // openDialog();
//     } else {
//       await prefs.setBool('seen', true);
//       Timer(const Duration(seconds: 3), () => {openDialog()});
//       //openDialog();
//     }
//   }
//
//
//   void openDialog() {
//     //await Future.delayed(const Duration(seconds: 1));
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: const Color(0xFFEC5497),
//             title: const Center(
//               child: Text("Hi! Welcome",
//                   style: TextStyle(
//                     color: Colors.white,
//                   )),
//             ),
//             contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//             content: Container(
//               color: Colors.white,
//               width: 300,
//               height: 200,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: Icon(
//                       Icons.face_outlined,
//                       color: Color(0xFFEC5497),
//                       size: 80,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     child: Text(
//                       "Great!",
//                       style: TextStyle(fontSize: 20),
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//   Future<void> _get_session() async {
//     setState(() {
//       isLoading = true;
//
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(email != null) {
//
//       setState(() {
//         name ??= prefs.getString('name');
//         user_id ??= prefs.getString('id');
//       });
//     }
//
//
//     prefs.setString('latitude', Get.arguments[0]['latitude']);
//     prefs.setString('longitude', Get.arguments[1]['longitude']);
//     prefs.setString('address', Get.arguments[2]['address']);
//     setState(() {
//       isLoading = false;
//
//     });
//     _markerIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/icons/marker.png');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//      // appBar: appBar(),
//      //  drawer: const NavigationDrawer(),
//       appBar: AppBar(
//
//
//         iconTheme: IconThemeData(color:  theme.primaryColor,),
//         title:Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset('assets/images/other/logo_blossom.png',
//             height: 150.0,
//             width: 220.0,
//           ),
//         ),
//
//         //title: Text('Appointment', style: theme.textTheme.headline3),
//         centerTitle: true,
//
//
//
//       ),
//
//       body: Stack(
//      // body: isLoading?const Center(child: CircularProgressIndicator()):Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition:  CameraPosition(
//               target: LatLng(latitude, longitude),
//               zoom: 17.0,
//             ),
//             markers: _markers,
//             zoomControlsEnabled: false,
//             onMapCreated: (GoogleMapController controller) {
//
//               setState(
//                 () {
//                   _markers.addAll(nearbylist);
//                   _markers.add(
//                     Marker(
//                       markerId: MarkerId('0'),
//                       position: LatLng(latitude, longitude),
//                       infoWindow: const InfoWindow(
//                         title: "You Are Here",
//                         snippet: 'lol ah',
//                       ),
//                       icon: _markerIcon,
//                     ),
//                   );
//                 },
//               );
//             },
//
//           ),
//           Positioned(
//             top: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child: headerContent(context),
//           ),
//           _isList
//               ? DraggableScrollableSheet(
//                   builder: (context, scrollController) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         color: theme.backgroundColor,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(25.0),
//                           topLeft: Radius.circular(25.0),
//                         ),
//                       ),
//                       child: ListView(
//                         padding: EdgeInsets.symmetric(horizontal: 18.0),
//                         controller: scrollController,
//                         children: [
//                           SizedBox(height: 10.0),
//                           Center(
//                             child: Container(
//                               width: 70.0,
//                               height: 5.0,
//                               decoration: BoxDecoration(
//                                 color: theme.unselectedWidgetColor,
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20.0),
//                           Text('Services Nearby',
//                               style: theme.textTheme.headline3),
//                           SizedBox(height: 4.0),
//                           // RichText(
//                           //   text: TextSpan(children: [
//                           //     TextSpan(
//                           //         text: "Found ",
//                           //         style: theme.textTheme.subtitle2),
//                           //     TextSpan(
//                           //         text: "320 Place ",
//                           //         style: theme.textTheme.subtitle2),
//                           //     TextSpan(
//                           //         text: "near ",
//                           //         style: theme.textTheme.subtitle2),
//                           //     TextSpan(
//                           //         text: "San Fransisco",
//                           //         style: theme.textTheme.subtitle2),
//                           //   ]),
//                           // ),
//                           SizedBox(height: 15.0),
//                           ChangeNotifierProvider(
//                             create: (context) => CategoryProvider(),
//                            // create: (context) => BestSalonProvider(),
//                             child: Builder(
//                               builder: (context) {
//                                 // final model = Provider.of<BestSalonProvider>(context);
//                                 // final bestsalon = model.bestsalonlist;
//                                 final model = Provider.of<CategoryProvider>(context);
//                                 final services = model.services;
//                                 return ListView.builder(
//                                  // itemCount: bestsalon.length,
//                                   itemCount: services.length,
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.vertical,
//                                   physics: ScrollPhysics(),
//                                   itemBuilder: (context, index) {
//                                     // CategoryModel service = services[index];
//                                   //  BestSalonModel salon = bestsalon[index];
//                                     //var salon = allSalonList[index];
//
//                                     return Container();
//                                     //return SalonSearchCard();
//                                   },
//                                 );
//                               }
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ):Container(),
//               // : Positioned(
//               //     bottom: 70.0,
//               //     left: 0.0,
//               //     right: 0.0,
//               //     child: Container(
//               //       height: 120.0,
//               //       child: ChangeNotifierProvider(
//               //         create: (context) => BestSalonProvider(),
//               //         child: Builder(
//               //           builder: (context) {
//               //             final model = Provider.of<BestSalonProvider>(context);
//               //             final bestsalon = model.bestsalonlist;
//               //             return ListView.builder(
//               //               itemCount: bestsalon.length,
//               //               //itemCount: allSalonList.length,
//               //               scrollDirection: Axis.horizontal,
//               //               shrinkWrap: true,
//               //               padding: EdgeInsets.symmetric(horizontal: 18.0),
//               //               itemBuilder: (context, index) {
//               //                // var salon = allSalonList[index];
//               //                 BestSalonModel salon = bestsalon[index];
//               //                 return SalonSearchHorizCard(
//               //                   salon: salon,
//               //                   margin: EdgeInsets.only(right: 15.0),
//               //                 );
//               //               },
//               //             );
//               //           }
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//           Positioned(
//             bottom: 70.0,
//             right: 18.0,
//             child: GestureDetector(
//               onTap: () {
//                 if (_isList == false) {
//                   setState(() {
//                     _isList = true;
//                   });
//                 } else {
//                   setState(() {
//                     _isList = false;
//                   });
//                 }
//               },
//               child: CircleAvatar(
//                 radius: 30.0,
//                 backgroundColor: theme.primaryColor,
//                 child: Icon(
//                     _isList
//                         ? Icons.menu
//                         : Icons.menu_book,
//                     // color: kBackgroundLightColor),
//               ),
//             ),
//           ),)
//         ],
//       ),
//     );
//   }
//   // void _setMarkerIcon() async {
//   //   _markerIcon = await BitmapDescriptor.fromAssetImage(
//   //       ImageConfiguration(), 'assets/icons/marker.png');
//   // }
//   _autoGetLocation() async {
//     setState(() {
//       isLoading = true;
//
//     });
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       latitude  = position.latitude;
//       longitude = position.longitude;
//     });
//
//
//     debugPrint('location: ${position.latitude},${position.longitude}');
//     List<Placemark> placemarks  = await placemarkFromCoordinates(position.latitude, position.longitude);
//     // final coordinates = new Coordinates(position.latitude, position.longitude);
//
//     // var addresses =  await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     Placemark placeMark  = placemarks[0];
//     String? name = placeMark.name;
//     String? subLocality = placeMark.subLocality;
//     String? locality = placeMark.locality;
//     String? administrativeArea = placeMark.administrativeArea;
//     String? postalCode = placeMark.postalCode;
//     String? country = placeMark.country;
//      address = "$name, $subLocality, $locality";
//
//
//     print('$address');
//     // setState(() {
//     //
//     //   _setMarkerIcon();
//     // });
//     _markerIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/icons/marker.png');
//     setState(() {
//       isLoading = false;
//
//     });
//
//   }
//   Future<void> _listenLocation() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     String? user_id =  prefs.getString('id');
//     _switchValue = true;
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print(onError);
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//
//       });
//     }).listen((loc.LocationData currentlocation) async {
//       await FirebaseFirestore.instance.collection('user_location').doc(user_id).set({
//         'latitude': currentlocation.latitude,
//         'longitude': currentlocation.longitude,
//         'id': user_id
//       }, SetOptions(merge: true));
//     });
//   }
//
//   Container headerContent(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       // width: Screen.width(context),
//       color: theme.cardColor,
// //      height: 200.0,
//       padding: EdgeInsets.symmetric(horizontal: 18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//          // Text('Your location', style: theme.textTheme.subtitle2),
//           SizedBox(height: 8.0),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.location_on,
//               ),
//               SizedBox(width: 5.0),
//               Expanded(child: Text(address, style: theme.textTheme.headline5)),
//               Spacer(),
//               Transform.rotate(
//                 angle: 31,
//                 child: Icon(
//                   Icons.send,
//                   color: Colors.grey,
//                   size: 15.0,
//                 ),
//               ),
//               SizedBox(width: 5.0),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(ChangeAddressPage());
//                 },
//                 child: Text(
//                   'CHANGE',
//                   style: theme.textTheme.subtitle2!.copyWith(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.0),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   // width: Screen.width(context),
//                   height: 40.0,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.only(top: 0.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25.0),
//                     color: theme.backgroundColor,
//                   ),
//                   child: Center(
//                     child: TextFormField(
//
//                       onTap: () {
//                         Get.to(SearchPage());
//                         //  showSearch(context: context, delegate: SearchPage());
//                       },
//
//                       readOnly: true,
//                       style: theme.textTheme.bodyText2,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         fillColor: theme.cardColor,
//                         hintText: 'Search salon, spa & barber services...',
//                         hintStyle: theme.textTheme.subtitle2,
//                         prefixIcon: IconButton(
//                           icon: Icon(Icons.search),
//                           onPressed: () {
//                             Get.to(SearchPage());
//                             // showSearch(
//                             //     context: context, delegate: SearchPage());
//                           },
//                         ),
//                         focusColor: theme.cardColor,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Expanded(
//               //   // flex: 2,
//               //   child: Container(
//               //     width: Screen.width(context),
//               //     height: 40.0,
//               //     alignment: Alignment.center,
//               //     padding: EdgeInsets.only(top: 0.0),
//               //     decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(25.0),
//               //       color: theme.backgroundColor,
//               //     ),
//               //     child: TextField(
//               //       style: theme.textTheme.bodyText2,
//               //       keyboardType: TextInputType.text,
//               //       autofocus: false,
//               //       autocorrect: false,
//               //       decoration: InputDecoration(
//               //         fillColor: theme.cardColor,
//               //         hintText: 'Search salon, spa & barber services...',
//               //         border: InputBorder.none,
//               //         enabledBorder: InputBorder.none,
//               //         focusedBorder: InputBorder.none,
//               //
//               //         hintStyle: theme.textTheme.subtitle2,
//               //         prefixIcon: IconButton(
//               //           icon: Icon(Icons.search),
//               //           onPressed: () {
//               //             Get.to(SearchPage());
//               //             //showSearch(context: context, delegate: SearchPage());
//               //           },
//               //         ),
//               //         focusColor: theme.cardColor,
//               //                   contentPadding: const EdgeInsets.symmetric(
//               //                     horizontal: 20.0,
//               //                   ),
//               //
//               //       ),
//               //     ),
//               //   ),
//               // ),
//
//             ],
//           ),
//           SizedBox(height: 12.0),
//         ],
//       ),
//     );
//   }
//
//   AppBar appBar() {
//     final theme = Theme.of(context);
//     return AppBar(
//       backgroundColor: theme.cardColor,
//       elevation: 0.0,
//       title: Text('Hello, $name', style: theme.textTheme.headline4),
//       leading: Container(),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.notifications_none,
// //            color: kWhiteColor,
//           ),
//           onPressed: () {
//             Get.to(NotificationPage());
//           },
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.file_copy_rounded,
// //            color: kWhiteColor,
//           ),
//           onPressed: () {
//             //Get.to(FilterPage());
//           },
//         ),
//       ],
//     );
//   }
//
//   Future<void> nearbyvendors() async {
//     setState(() {
//       isLoading = true;
//
//     });
//     print("hello banner");
//
//     //var response = await  http.get(Uri.parse('https://thesoftwareplanet.com/softmantissa/flutter_api/user/get_mechanic'));
//     var response = await  http.post(
//       Uri.parse('${Config.BASEURL}user/nearby_vendors'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'latitude': '$latitude',
//         'longitude': '$longitude'
//
//       }),
//     );
//
//
//
//
//     final data = json.decode(response.body);
//     print("hello banner 2");
//     print(data);
//     final  List responseBody = data['Nearby'];
//
//     // imagesList.addAll(data['BannerData']) ;
//     // print(responseBody.length);
//     for(var i in responseBody) {
//
//       setState(()  {
//         latitude =  double.parse(i['latitude'].toString());
//         longitude =  double.parse(i['longitude'].toString());
//
//         nearbylist.add(
//           Marker(
//             markerId: MarkerId(i['id']),
//             position: LatLng(latitude, longitude),
//             infoWindow: InfoWindow(title: i['name']),
//              icon: _markerIcon,
//             //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//           ),
//           //  i['latitude'],
//
//         );
//       });
//       print(nearbylist.length);
//       print("hello nearby ${i['name']}");
//       print("gfhgvhg ${latitude},${longitude}");
//     }
//     setState(() {
//       isLoading = false;
//
//     });
//
//   }
//
// }
//
// class NotificationPage {
// }
