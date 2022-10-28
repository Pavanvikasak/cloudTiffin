import 'dart:convert';



import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/colors.dart';
class OrderFailedPage extends StatefulWidget {
  const OrderFailedPage({Key? key}) : super(key: key);

  @override
  _OrderFailedPageState createState() => _OrderFailedPageState();
}

class _OrderFailedPageState extends State<OrderFailedPage> {
  String? id;


  // For Deleting User

  void initState() {
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    //final bankProvider = BankProvider();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kredColor,
        title: Text("Sorry"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0),


              Center(child: Image(image: AssetImage('assets/images/failed.png'),)),
              SizedBox(height: 35.0),
              Text(
                'Your Order Has Been Failed Due to  ',
                style:  theme.textTheme.headline6,
              ),
              Text(
                'Product Quantity not available',
                style:  theme.textTheme.headline6,
              ),
              Text(
                'Click to back button',
                style:  theme.textTheme.headline6,
              ),
              SizedBox(height: 85.0),
              Center(
                child: Container(

                  child: ElevatedButton(
                    onPressed: () {

                      Get.to(()=>BotNav()

                      );

                      // Navigate to Home & Sending Email to Next Screen.
                      //  home();


                      //toast('Successfully added Stylist!');
                    },
                    child: Text('Back To Home ',

                        style: theme.textTheme.button),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );

  }

  Future home()  async {
    //await  Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();







    //toast(data['ResponseMsg']);
    double? lat =   prefs.getDouble('latitude');
    double? lng =    prefs.getDouble('longitude');
    String? address =  prefs.getString("address");

    // Navigate to Home & Sending Email to Next Screen.
    Get.offAll(
        BotNav(), arguments: [
      {'latitude': '${lat}'},
      {'longitude': '${lng}'},
      {'address': '${address}'}
    ]

    );





  }
}

