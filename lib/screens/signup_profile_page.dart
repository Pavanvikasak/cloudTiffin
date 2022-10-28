import 'dart:convert';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart' show FlutterIcons;
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../config.dart';
import 'ask_location_page.dart';
enum Gender { Male, Female }

class SignupProfilePage extends StatefulWidget {
  const SignupProfilePage({Key? key}) : super(key: key);

  @override
  State<SignupProfilePage> createState() => _SignupProfilePageState();
}

class _SignupProfilePageState extends State<SignupProfilePage> {
  final argumentData = Get.arguments;
  Gender? _genderPicked = Gender.Male;
  String? userid;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override initState(){
    super.initState();
    setState(() {
      userid= Get.arguments[0]['user_id'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kwhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: screen.width(context)*0.3,
              ),
              kTextstyle(myText: "Enter Profile Details",myWeight: FontWeight.w600,mySize: 18),
              Container(
                height: 210,
                width: 210,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(
                    "assets/images/111.png"
                ),fit: BoxFit.cover)),
              ),

              SizedBox(height: 28,),
              Container(padding: EdgeInsets.only(left: 16,top: 2),
                alignment: Alignment.center,
                decoration:BoxDecoration(color: kwhiteColor,
                    border: Border.all(width: 2,color: kredColor),
                    borderRadius: BorderRadius.circular(36)) ,
                child: TextFormField(
                  controller: nameController,
                  validator: null,
                  onChanged: null,
                  obscureText: false,
                  decoration: InputDecoration(border: InputBorder.none,
                    hintText: 'Enter full name',
                    hintStyle: GoogleFonts.poppins(fontSize: 14,letterSpacing: 0.8,fontWeight: FontWeight.w600),
                    suffixIcon: Icon(FlutterIcons.user_fea),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(padding: EdgeInsets.only(left: 16,top: 2),
                alignment: Alignment.center,
                decoration:BoxDecoration(color: kwhiteColor,
                    border: Border.all(width: 2,color: kredColor),
                    borderRadius: BorderRadius.circular(36)) ,
                child: TextFormField(
                  controller: emailController,
                  validator: null,
                  onChanged: null,
                  obscureText: false,

                  decoration: InputDecoration(border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(fontSize: 14,letterSpacing: 0.8,fontWeight: FontWeight.w600),
                    hintText: 'Enter email address',
                    suffixIcon: Icon(FlutterIcons.mail_fea),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  SizedBox(width: 16,),
                  kTextstyle(myText: "Gender",mySize: 16,myWeight: FontWeight.w600),
                  Radio(
                    value: Gender.Male,
                    groupValue: _genderPicked,
                    focusColor: kgreenColor,
                    activeColor:kgreenColor,
                    hoverColor: kgreenColor,
                    onChanged: (dynamic value) {
                      setState(() {
                        _genderPicked = value;
                      });
                    },
                  ),
                  kTextstyle(myText: "Male",mySize: 14,myWeight: FontWeight.w600),
                  SizedBox(width: 20.0),
                  Radio(
                    value: Gender.Female,
                    groupValue: _genderPicked,
                    focusColor: kgreenColor,
                    activeColor: kgreenColor,
                    hoverColor: kgreenColor,
                    onChanged: (dynamic value) {
                      setState(() {
                        _genderPicked = value;
                      });
                    },
                  ),
                  kTextstyle(myText: "Female",mySize: 14,myWeight: FontWeight.w600),
                ],
              ),
              SizedBox(height: 64,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      UpdateProfile();
                      // Get.to(()=>AskLocationScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        primary: kredColor,
                        elevation: 4,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: kredColor)),
                        minimumSize: Size(240, 48),
                        splashFactory: InkRipple.splashFactory),
                    child: kTextstyle(
                        myText: "Submit ",
                        mySize: 16,
                        myWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future UpdateProfile() async {


    String name = nameController.text;
    String email = emailController.text;
    print(name);
    print(email);
    print(_genderPicked.toString().substring(7));


    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/profile_update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',},
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'gender': _genderPicked.toString().substring(7),
        'user_id': 'user_id',
        // 'device_token': "$token",
        // 'location': "address"

      }),);

    var data = jsonDecode(response.body);
    print("response from body $data");

    if (data['ResponseCode'] == '200') {
      var responseBody = data['user_id'];
      print(responseBody);


      //toast(data['ResponseMsg']);
      Get.to(()=>AskLocationScreen());


      // Get.to(()=>VerifyOtpPage(), arguments: [
      //   {'user_id': '$responseBody',},
      //   {'number': numberController.text}]);

      // Navigate to Home & Sending Email to Next Screen.
      //Navigator.pushNamed(context, '/HomePage');
    } else {
      toast(data['ResponseMsg']);

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.

    }
  }
}