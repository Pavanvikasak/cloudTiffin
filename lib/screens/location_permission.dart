import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/colors.dart';
import '../helper/routes.dart';
import '../helper/theme.dart';
import 'bottom_navigation.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({Key? key}) : super(key: key);

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: screen.width * .2,
            ),
            Container(
              width: double.maxFinite,
              height: 280,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/location.png'))),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: kTextstyle(
                  myText: "Location Permission",
                  mySize: 20,
                  myWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              child: kTextstyle(
                  myDirection: TextAlign.center,
                  myColor: Colors.grey,
                  myText:
                      "Please enable your Location to get better search results in your area.",
                  mySize: 12,
                  lines: 2),
            ),
            Padding(
              padding: EdgeInsets.only(top: screen.height * 0.2),
              child: ElevatedButton(
                  onPressed: () {
                    print("Location allow");
                    // Get.offAll(()=> VerifyOtpPage(),arguments:[{"number": numberController.text}] );

                    Get.to(() => BotNav());
                    // Navigator.pushNamed(context, MyRoutes.BotnavPage);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kredColor,
                      minimumSize: Size(screen.width - 48, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  child: kTextstyle(
                      myText: "ALLOW LOCATION",
                      mySize: 14,
                      myWeight: FontWeight.w600,
                      myColor: kwhiteColor)),
            ),
            TextButton(
                onPressed: () {
                  Get.to(()=> BotNav());
                  Navigator.pushNamed(context, MyRoutes.BotnavPage, );
                },
                child: kTextstyle(
                    myText: 'Skip for now', mySize: 14, myColor: kblackcolor))
          ],
        ),
      ),
    );
  }
}
