import 'dart:convert';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

enum Gender { Male, Female }

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool visible = false;

  Gender? _genderPicked = Gender.Male;
  String? selectedGender="";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // _get_session();

    super.initState();

    getProfile();
  }

  // Future<void> _get_session() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await prefs.clear();
  //   //email = prefs.getString('email')!;
  //   emailController.text = prefs.getString('email')!;
  //   nameController.text = prefs.getString('name')!;
  //   //name = prefs.getString('name')!;
  //   // String? name = prefs.getString('name');
  //   // String? id = prefs.getString('id');
  //
  // }

  Future<void> getProfile() async {
    setState(() {
      visible = true;
    });
    final prefs = await SharedPreferences.getInstance();

    String? user_id = prefs.getString('id');
    print("hello bank $user_id");

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/user_profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': '$user_id',
      }),
    );

    final data = json.decode(response.body);

    final List responseBody = data['profileinfo'];
    print(responseBody);

    for (var i in responseBody) {
      setState(() {
        nameController.text = i['name'];
        emailController.text = i['email'];
        selectedGender = i['gender'];
      });
    }
    setState(() {
      visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final signUpProv = Provider.of<SignUpProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kredColor,
        foregroundColor: kwhiteColor,
        title: kTextstyle(
            myText: 'Edit Profile', mySize: 18, myWeight: FontWeight.w600),
        // centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kwhiteColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // changeProfileImage(context),
              Container(
                width: screen.width(context),
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: null,
                      onChanged: null,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        suffixIcon: Icon(FlutterIcons.user_fea),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: emailController,
                      validator: null,
                      onChanged: null,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        suffixIcon: Icon(FlutterIcons.mail_fea),
                      ),
                    ),
                    SizedBox(height: 15.0),

                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: theme.textTheme.bodyText2,
                        ),
                        Radio(
                          // groupValue: _genderPicked,
                          // value: selectedGender!='Male'?selectedGender:Gender.Male,
                          value: selectedGender == 'Male' ? selectedGender:'Male',
                          groupValue: selectedGender,
                          focusColor: theme.primaryColor,
                          activeColor: theme.primaryColor,
                          hoverColor: theme.unselectedWidgetColor,
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        Text(
                          'Male',
                          style: theme.textTheme.subtitle1,
                        ),
                        SizedBox(width: 20.0),
                        Radio(
                          // groupValue: Gender.Female,
                          // value: selectedGender!='Female'?selectedGender:Gender.Female,
                          value: selectedGender == 'Female' ? selectedGender:'Female',
                          groupValue: selectedGender,
                          focusColor: theme.primaryColor,
                          activeColor: theme.primaryColor,
                          hoverColor: theme.unselectedWidgetColor,
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        Text(
                          'Female',
                          style: theme.textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    // SizedBox(
                    //   width: Screen.width(context),
                    //   height: 45.0,
                    //   child: TextFormField(
                    //     controller: phoneController,
                    //     style: theme.textTheme.bodyText2,
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //       hintText: 'Phone no',
                    //       suffixIcon: Icon(FlutterIcons.mail_fea),
                    //     ),
                    //   ),
                    // ),
                    ///====================================================================
                    // SizedBox(height: 12.0),
                    // SizedBox(
                    //   width: screen.width(context),
                    //   height: 45.0,
                    //   child: TextFormField(
                    //     controller: passwordController,
                    //     style: theme.textTheme.bodyText2,
                    //     // obscureText: signUpProv.obscureText1,
                    //     decoration: InputDecoration(
                    //       hintText: 'Password',
                    //       // suffixIcon: IconButton(
                    //       //   icon: Icon(signUpProv.obscureText1
                    //       //       ? FlutterIcons.visibility_off_mdi
                    //       //       : FlutterIcons.visibility_mdi),
                    //       //   onPressed: () {
                    //       //     signUpProv.hidePassword();
                    //       //   },
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                    // Text(
                    //   'Your email verification is still pending.\nPlease verify your account.',
                    //   textAlign: TextAlign.center,
                    //   style: theme.textTheme.subtitle2,
                    // ),
                    SizedBox(height: 15.0),
                    SizedBox(
                      width: screen.width(context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(180, 48),
                          primary: kredColor,
                          onPrimary: kwhiteColor,
                          onSurface: kwhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: kredColor)),
                        ),
                        onPressed: () {
                          profileUpdate();
                          // Get.back();
                          // toast('Successfully change profile info');
                        },
                        child: kTextstyle(
                          myText: 'Update Profile',
                          mySize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Container changeProfileImage(BuildContext context) {
  //   final theme = Theme.of(context);
  //
  //   return Container(
  //     width: screen.width(context),
  //     height: 150.0,
  //     child: Center(
  //       child: Stack(
  //         children: [
  //           CircleAvatar(
  //             radius: 60.0,
  //             backgroundColor: theme.unselectedWidgetColor,
  //             backgroundImage: AssetImage(
  //               'assets/images/logo.png',
  //             ),
  //           ),
  //           InkWell(
  //             borderRadius: BorderRadius.circular(120.0),
  //             onTap: () => showFilePicker(FileType.image),
  //             child: Container(
  //               width: 120.0,
  //               height: 120.0,
  //               decoration: BoxDecoration(
  //                 color: theme.primaryColor.withOpacity(.7),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Icon(
  //                 FlutterIcons.camera_fea,
  //                 color: kredColor,
  //                 size: 40.0,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Future profileUpdate() async {
    await Future.delayed(const Duration(seconds: 2));
    //  await EasyLoading.show(
    //    status: 'loading...',
    //    maskType: EasyLoadingMaskType.black,
    //  );
    //EasyLoading.show();
    final prefs = await SharedPreferences.getInstance();
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String? name = nameController.text;
    String? email = emailController.text;
    String? gender = selectedGender;

    String? user_id = prefs.getString('id');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/profile_update'),
      //Uri.parse('https://thesoftwareplanet.com/blossom/flutter_api/user/profile_update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': "$user_id",
        'name': name,
        'email': email,
        'gender': "$gender"
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
      prefs.setString('email', email);
      prefs.setString('name', name);

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      toast(data['ResponseMsg']);
      // Navigate to Home & Sending Email to Next Screen.

      // Navigator.pushNamed(context, '/HomePage', arguments: [
      //   {'latitude': '${latitude}'},
      //   {'longitude': '${longitude}'},
      //   {'address': '${address}'}
      // ]);
    } else {
      // EasyLoading.showError('Invalid Credentials');
      toast(data['ResponseMsg']);
      // toast('Something wrong');
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
    }
  }
//
// showFilePicker(FileType fileType) async {
//
//   toast('Profile image changed!');
//
// }

}