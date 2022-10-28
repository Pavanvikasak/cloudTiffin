import 'dart:convert';

import 'package:cloud_tiffin/config.dart';
import 'package:cloud_tiffin/screens/ask_location_page.dart';
import 'package:cloud_tiffin/screens/signup_profile.dart';


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../helper/colors.dart';
import '../helper/routes.dart';
import '../helper/theme.dart';
import '../provider/phone_verification_provider.dart';


class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({Key? key}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  dynamic argumentData = Get.arguments;
  bool visible = false ;
  String? user_id;
  String email='';

  TextEditingController otpController = TextEditingController();


  @override
  void initState() {
    // user_id = Get.arguments[0]["user_id"];

    // print('hello ' + Get.arguments[0]["number"]);
    super.initState();

    setState(() {
      user_id=   Get.arguments[0]['user_id'];
    });
    // print('hello ' + Get.arguments[0]['user_id']);
    //  print('hello2 ' + Get.arguments[1]['number']);


  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final phoneVerifyProv = Provider.of<PhoneVerificationProvider>(context);
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
                      image: AssetImage('assets/images/OTP.png'))),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: kTextstyle(
                  myText: "Verify Otp", mySize: 20, myWeight: FontWeight.w600),
            ),
            kTextstyle(
                myText: "We have sent yo a text, with a code, to",
                mySize: 12,
                myWeight: FontWeight.w400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kTextstyle(
                    myText: '${Get.arguments[1]['number']}' + " ",
                    mySize: 12,
                    myWeight: FontWeight.w600),
                kTextstyle(
                    myText: 'please enter 4 digit code',
                    mySize: 12,
                    myWeight: FontWeight.w400),
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PinInputTextFormField(
                pinLength: 4,
                keyboardType: TextInputType.number,
                autoFocus: false,
                controller: otpController ,
                // controller: phoneVerifyProv.codeCtrl,
               // onChanged: (value) => phoneVerifyProv.onSavedCode(value),
                decoration: BoxLooseDecoration(
                  radius: Radius.circular(25.0),
                  textStyle: theme.textTheme.headline4!,
                  strokeColorBuilder: PinListenColorBuilder(
                      theme.primaryColor, theme.accentColor),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ElevatedButton(
                  onPressed: () {
                    print("Verify OTP");
                    // Get.offAll(()=> VerifyOtpPage(),arguments:[{"number": numberController.text}] );
                    // Get.to(()=>BotNav());
                   // Get.to(verifyOtp());
                    verifyOtp();
                    // Get.to(() => LocationPermissionPage());
                    // Navigator.pushNamed(context, MyRoutes.BotnavPage, );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kredColor,
                      minimumSize: Size(screen.width - 48, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  child: kTextstyle(
                      myText: "Verify OTP",
                      mySize: 14,
                      myWeight: FontWeight.w600,
                      myColor: kwhiteColor)),
            ),
          ],
        ),
      ),
    );
  }

  Future verifyOtp() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      visible = true;
    });

    String otp = otpController.text;

    print(otp);

    print(user_id);
    var response = await http.post(
      Uri.parse(
          '${Config.BASEURL}user/verify_phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "otp": otp,
        "user_id": "$user_id",
        // 'password': password,
      }),
    );
    //var response = await http.post(url, body: json.encode(data[email]));

    // Getting Server response into variable.
    var data = jsonDecode(response.body);
    print(data);

    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      //EasyLoading.dismiss();
      var responseBody = data['user'];
      print(responseBody);
      prefs.setString('phone', responseBody['phone_no']);
      // prefs.setString('name', name);
      prefs.setString('id', '$user_id');
      // address = prefs.getString('address');
      // latitude = prefs.getString('latitude');
      // longitude = prefs.getString('longitude');
      // Hiding the CircularProgressIndicator.
     // toast(data['ResponseMsg']);
      if(responseBody['name'] == null) {
        Get.to(() => SignupProfilePage(), arguments: [{'user_id': '$user_id'}]);
      }else {
        Get.to(AskLocationScreen());
      }
      // Get.offAll(
      //
      //
      //
      // );

      // Navigate to Home & Sending Email to Next Screen.
      //Navigator.pushNamed(context, MyRoutes.BotnavPage);
    } else {
      // EasyLoading.showError('Invalid Credentials');
      toast(data['ResponseMsg']);

      setState(() {
        visible = false;
      });
    }
  }
}
