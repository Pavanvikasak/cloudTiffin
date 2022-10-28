import 'dart:async';
import 'dart:collection';
import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geocode/geocode.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;

import '../helper/colors.dart';
import '../helper/theme.dart';


class DirectionPage extends StatefulWidget {


  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {

  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  GoogleMapPolyline _googleMapPolyline =
  new GoogleMapPolyline(apiKey: "AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM");

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  bool isLocation =false;
  //final databaseRef = FirebaseDatabase.instance.reference();

  TextEditingController reasonController = TextEditingController();
  var data = Get.arguments;
  bool visible = false ;
 // String? locationNew = Get.arguments[0]["location"];
   String? id;
   String? shop_name ;

  String?  user_id;
  final loc.Location location2 = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  late BitmapDescriptor _markerIcon;
  Set<Marker> _markers = HashSet<Marker>();
  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();


  String googleAPIKey = "AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM";
  Map<MarkerId, Marker> markers = {};
  final Set<Polyline> _polyline = {};


  bool isLoading = false;
  late double myLat;
  late double myLng;
  late double destLat;
  late double destLng;
  var totaldistance;

  @override
  void initState() {
    super.initState();
    myLocation();
    setState(() {
      id = Get.arguments[0]["id"];
      shop_name = Get.arguments[0]["shop_name"];

    });
    // _listenLocation();
   // _setMarkerIcon();

    //  _get_estimatetime();
    // _createPolylines();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(

      appBar: AppBar(backgroundColor: kredColor,
        elevation: 0,
        shadowColor: kwhiteColor,
        leadingWidth: 36,
        title: kTextstyle(myText: 'Direction',mySize: 18,myWeight: FontWeight.w600),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kwhiteColor,
          onPressed: () {
            Get.back();

          },
        ),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('kitchen_provider').snapshots(),
              builder: (context, snapshot) {
                if (_added) {
                  mymap(snapshot);
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return GoogleMap(
                  mapType: MapType.normal,
                  //myLocationButtonEnabled: true,
                  markers: {
                    Marker(
                        position: LatLng(
                          snapshot.data!.docs.singleWhere(
                                  (element) => element.id == id)['latitude'],
                          snapshot.data!.docs.singleWhere(
                                  (element) => element.id == id)['longitude'],
                        ),
                        markerId: MarkerId('id'),
                        infoWindow: const InfoWindow(
                          title: 'shop',

                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueMagenta)),
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(myLat, myLng),
                      infoWindow: const InfoWindow(
                        title: "You are here",

                      ),
                    ),
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        snapshot.data!.docs.singleWhere(
                                (element) => element.id == id)['latitude'],
                        snapshot.data!.docs.singleWhere(
                                (element) => element.id == id)['longitude'],
                      ),
                      zoom: 18.47),
                  onMapCreated: (GoogleMapController controller) async {
                    setState(() {
                      _controller = controller;
                      _added = true;
                      destLat = snapshot.data!.docs.singleWhere(
                              (element) => element.id == id)['latitude'];
                      destLng = snapshot.data!.docs.singleWhere(
                              (element) => element.id == id)['longitude'];


                    });
                    _getPolylinesWithLocation(destLat,destLng);
                     //_createPolylines(destLat,destLng);
                    //_get_estimatetime(destLat,destLng);
                  },
                );

              }
          ),



        ],

      ),
    );
  }








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
  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == id)['latitude'],
          snapshot.data!.docs.singleWhere(
                  (element) => element.id == id)['longitude'],
        ),
        zoom: 19.47)));
    // _get_estimatetime(destLat,destLng);
  }


  void myLocation() async {
    setState(() {
      isLoading = true;
    });

    Position position = await _getGeoLocationPosition();
    // Timer(const Duration(seconds: 10), () {});
    print(position);
    print(position.latitude);
    print(position.longitude);
    setState(() {
      myLat = position.latitude;
      myLng = position.longitude;
    });
    // _get_estimatetime();
    // _createPolylines();



    setState(() {
      isLoading = false;
    });
  }

  _get_estimatetime(destLat,destLng) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$myLat,$myLng&destinations=$destLat,$destLng&key=AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM'));

    // print(response);


    var data = json.decode(response.body);
    print("hello estimate time");
    print(data);
    var newvalue;
    var myString = data['rows'];
    for (var index = 0; index < myString.length; ++index) {
      final value = myString[index];

      newvalue = value['elements'];
      print(value['elements']);
    }

    for (var index = 0; index < newvalue.length; ++index) {
      final mvalue = newvalue[index];

      setState(() {
        totaldistance = mvalue['duration']['text'];
      });
      print(mvalue['duration']['text']);
    }
  }
  _getPolylinesWithLocation(destLat,destLng) async {

    List<LatLng>? _coordinates =
    await _googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(myLat,myLng),
        destination: LatLng(destLat,destLng),
        mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyLine(_coordinates);


  }
  _createPolylines(destLat,destLng) async {
    print("////////////////ployline created call/////////////////");
    // double _originLatitude = 26.48424;
    // double _originLongitude = 50.04551;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(myLat, myLng),

      PointLatLng(destLat, destLng),
      travelMode: TravelMode.transit,
      // wayPoints: [PolylineWayPoint(location: "$locationNew")]
    );
    // wayPoints: [PolylineWayPoint(location: "kawardha")]);
    print("hey ${result.points}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        // print("hey inside loop${result.points}");
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        //_addPolyLine(point.latitude, point.longitude);
      });
    }
    // _addPolyLine();
  }

  _addPolyLine(List<LatLng>? _coordinates) {
    //_addPolyLine(double latitude, double longitude ){
    // print("call ployline ${latitude},${longitude}");
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(

      polylineId: id,
      patterns: [PatternItem.dot, PatternItem.gap(10)],
      visible: true,
      // geodesic: true,
      color: Colors.blue,
      startCap: Cap.roundCap,
      // endCap: Cap.roundCap,
      //     points: [
      //       LatLng(latitude, longitude),
      //
      //    ],
      // );
      points: _coordinates!,
      // points: polylineCoordinates
    );
    polylines[id] = polyline;
    setState(() {
      isLoading = false;
    });
  }


}

