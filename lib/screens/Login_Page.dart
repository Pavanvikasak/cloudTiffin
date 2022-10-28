import 'dart:convert';

import 'package:cloud_tiffin/helper/routes.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:cloud_tiffin/screens/sign_in_with_email_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../helper/colors.dart';
import '../helper/theme.dart';
import 'package:http/http.dart' as http;

import 'otp_verify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? token;

  bool visible = false;
  final numberController = TextEditingController();

  // final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_fcm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screen.heigth(context) * 0.28,
          ),
          Container(
            height: 300,
            width: screen.width(context) - 86,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'))),
          ),
          Container(
            height: screen.heigth(context) * 0.5,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kblackcolor.withOpacity(0.25),
                      offset: Offset(0, 0),
                      blurRadius: 12)
                ],
                color: kwhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(children: [
                TextFormField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  key: _formKey,
                  controller: numberController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      floatingLabelStyle: GoogleFonts.poppins(fontSize: 16),
                      label: kTextstyle(
                          myText: "Enter Phone Number",
                          mySize: 16,
                          myColor: kblackcolor,
                          myWeight: FontWeight.w600),
                      hintText: "Ex - 12345678 ",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.5)),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        gapPadding: 8,
                        borderSide: BorderSide(color: Colors.blue, width: 4),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        gapPadding: 18,
                        borderSide: BorderSide(color: Colors.red, width: 4),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: ElevatedButton(
                      onPressed: () {
                        userSignup();
                        print('signup '+numberController.text);
                        // Get.to(()=> userSignup());
                        // Navigator.popAndPushNamed(context, userSignup());
                        // Get.to(() =>userSignup() ,
                        // //     arguments: [
                        // //   {'number': numberController.text}
                        // // ]
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        minimumSize: Size(screen.width(context) - 48, 42),
                        primary: kredColor,
                      ),
                      child: kTextstyle(
                          myText: 'Sign in',
                          mySize: 14,
                          myWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 32,
                ),
                kTextstyle(
                    myText: 'By continuing you agree to our',
                    mySize: 12,
                    myWeight: FontWeight.w400),
                kTextstyle(
                    myText: 'Terms and Conditions & Privacy policy',
                    mySize: 14,
                    myWeight: FontWeight.w500),


SizedBox(height: 24,),
                kTextstyle(
                    myText: 'Or',
                    mySize: 14,
                    myWeight: FontWeight.w500),
                InkWell(
                    onTap: (){
                       Get.to(SignInWithEmailPage());
        // Navigator.pushNamed(context, MyRoutes.BotnavPage);
                    },
                    child: kTextstyle(myText: 'login with email password',mySize: 16,myWeight: FontWeight.w500))

              ]),
            ),
          ),
        ],
      ),
    ));
  }

  Future userSignup() async {

    setState(() {
      visible = true;
    });
    String phone = numberController.text;

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',},
      body: jsonEncode(<String, String>{
        'phone': phone,
        'device_token': "$token",
        'location': "raipur"

      }),);

    var data = jsonDecode(response.body);
    print("response from body $data");

    if (data['ResponseCode'] == '200') {
      var responseBody = data['user_id'];
      print(responseBody);

      setState(() {
        visible = false;
      });
      //toast(data['ResponseMsg']);
        Navigator.of(context).pushNamed(MyRoutes.VerifyOtpPage,arguments: [
        {'user_id': '$responseBody'},
        {'number': numberController.text}]);


      // Get.to(()=>VerifyOtpPage(), arguments: [
      //   {'user_id': '$responseBody',},
      //   {'number': numberController.text}]);

      // Navigate to Home & Sending Email to Next Screen.
      //Navigator.pushNamed(context, '/HomePage');
    } else {
      toast(data['ResponseMsg']);

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
    }
  }
  void get_fcm()  {
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      print('device token :  $token');
    });
  }
}

//
//
