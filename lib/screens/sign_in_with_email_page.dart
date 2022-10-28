import 'dart:convert';

import 'package:cloud_tiffin/config.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/ask_location_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/colors.dart';
import '../helper/theme.dart';
import '../provider/sign_in_provider.dart';

class SignInWithEmailPage extends StatefulWidget {
  @override
  State<SignInWithEmailPage> createState() => _SignInWithEmailPageState();
}

class _SignInWithEmailPageState extends State<SignInWithEmailPage> {
  bool visible = false;
  String? token;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? address;
  String? latitude;
  String? longitude;
  @override
  void initState() {
    super.initState();

    get_fcm();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final signInProv = Provider.of<SignInProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/logo.png'),
          DraggableScrollableSheet(
            maxChildSize: 1.0,
            minChildSize: .7,
            initialChildSize: .7,
            builder: (context, scrollController) {
              return Container(
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome back',
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: kredColor),
                      ),
                      SizedBox(height: 50.0),
                      SizedBox(
                        width: screen.width(context),
                        height: 45.0,
                        child: TextFormField(
                          controller: emailController,
                          style: theme.textTheme.bodyText2,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: screen.width(context),
                        height: 45.0,
                        child: TextFormField(
                          controller: passwordController,
                          style: theme.textTheme.bodyText2,
                          obscureText: signInProv.obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(signInProv.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                signInProv.changeObscureText();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 35.0),
                      SizedBox(
                        width: screen.width(context),
                        child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login.....')),
                              );
                              userLogin();
                              // Get.to(BottomNavigationBarPage());
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
                      SizedBox(height: 15.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future userLogin() async {
    final prefs = await SharedPreferences.getInstance();
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;
    print(email);

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/new_user_login'),
      // Uri.parse('https://thesoftwareplanet.com/aayra/flutter_api/user/new_user_login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'device_token': '$token',
      }),
    );
    //var response = await http.post(url, body: json.encode(data[email]));

    // Getting Server response into variable.
    var data = jsonDecode(response.body);
    print(data);

    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      var responseBody = data['user'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${data['ResponseMsg']}")),
      );
      print(responseBody);
      prefs.setString('email', responseBody['email']);
      prefs.setString('name', responseBody['name']);
      prefs.setString('id', responseBody['id']);
      address = prefs.getString('address');
      latitude = prefs.getString('latitude');
      longitude = prefs.getString('longitude');
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      Get.off(AskLocationScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${data['ResponseMsg']}")),
      );
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
    }
  }

  void get_fcm() {
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      print('device token :  $token');
    });
  }
}
