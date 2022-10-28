// import 'package:cloud_tiffin/helper/locationpath.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
//
// import 'package:geolocator/geolocator.dart';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
// class AppState extends ChangeNotifier{
//   static LatLng? _initialPosition;
//   static LatLng? _lastPosition;
//   GoogleMapController _mapController;
//   Map Set_markers={};
//   Set  _polyLines={};
//   bool _isLoading=false;
//
//   //To Handle Text fileds data
//   TextEditingController sourceController=TextEditingController();
//   TextEditingController destController=TextEditingController();
//
//   //To Get the Marker Psotions
//   LatLng? get initialPosition => _initialPosition;
//   LatLng? get lastposition => _lastPosition;
//
//   //To check the Route Fetching stage
//   bool get isLoading => _isLoading;
//
//   GoogleMapController get mapController => _mapController;
//
//   //TO Load Markers on to Map
//   Set get markers => markers;
//
//   //To Load route on Map
//   Set get polyLines => _polyLines;
//
//   Locationpath _locationPath = Locationpath();
//   AppState()
//   {
//     _getUserLocation();
//   }
//   //  ON CREATE, Will set the MapController after loading the Map
//   void onCreated(GoogleMapController controller) {
//     _mapController = controller;
//     notifyListeners();
//   }
//
//   // Handle the CameraMove Position
//   void onCameraMove(CameraPosition position) {
//     _lastPosition = position.target;
//     notifyListeners();
//   }
//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
// // Fetch the User Current location
//   void _getUserLocation() async {
//     Position position = await _getGeoLocationPosition();
//     // Timer(const Duration(seconds: 10), () {});
//     print(position);
//     print(position.latitude);
//     print(position.longitude);
//     List<Placemark> placemarks =
//     await placemarkFromCoordinates(
//         position.latitude, position.longitude);
//     Placemark place = placemarks[0];
//    // String placeName = place.name.toString();
//     _initialPosition = LatLng(position.latitude, position.longitude);
//
//     sourceController.text =place.name.toString();
//     markers.add(Marker(markerId: MarkerId(position.toString()),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),position: LatLng(position.latitude, position.longitude)));
//     notifyListeners();
//   }
//
//   // To Request Route path to Goolge Webservice
//   // void sendRequest(String intendedLocation) async {
//   //   _isLoading=true;
//   //   var addresses = await Geocoder2.local.findAddressesFromQuery(intendedLocation);
//   //
//   //   double latitude = addresses.position.latitude;
//   //   double longitude = addresses.position.longitude;
//   //   LatLng destination = LatLng(latitude, longitude);
//   //   _addMarker(destination, intendedLocation);
//   //   String route = await _locationPath.getRouteCoordinates(
//   //       _initialPosition!, destination);
//   //   createRoute(route);
//   //   notifyListeners();
//   // }
//
//   // Add marker to markers set and update Map on Marker
//   void _addMarker(LatLng location, String address) {
//     markers.add(Marker(
//         markerId: MarkerId(_lastPosition.toString()),
//         position: location,
//         infoWindow: InfoWindow(title: address, snippet: "Destination"),
//         icon: BitmapDescriptor.defaultMarker));
//     notifyListeners();
//   }
// // ! TO CREATE ROUTE
// //   void createRoute(String encondedPoly) {
// //     _polyLines.add(Polyline(
// //         polylineId: PolylineId(_lastPosition.toString()),
// //         width: 4,
// //         points: _convertToLatLng(_decodePoly(encondedPoly)),
// //         color: Colors.deepPurple));
// //     _isLoading=false;
// //     notifyListeners();
// //   }
//
//   List _convertToLatLng(List points) {
//     List result = [];
//     for (int i = 0; i < points.length; i++) {
//       if (i % 2 != 0) {
//         result.add(LatLng(points[i - 1], points[i]));
//       }
//     }
//     return result;
//   }
//   // DECODE POLY
//   List _decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = [];
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
//
//     do {
//       var shift = 0;
//       int result = 0;
//
//
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);
//
// /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
//
//     print(lList.toString());
//
//     return lList;
//   }
// }
//
