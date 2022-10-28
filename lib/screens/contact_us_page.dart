import 'dart:convert';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _namec = TextEditingController();
  TextEditingController _numberc = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _message = TextEditingController();
  TextEditingController _cityc = TextEditingController();
  TextEditingController _state = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: kredColor,
          title: kTextstyle(myText: "Contact Us"),
        ),
        body: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: screen.width(context),
                height: screen.heigth(context) * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cont.jpg'),
                        fit: BoxFit.cover)),
              ),
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    Container(
                      width: screen.width(context) * 0.95,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(
                          top: screen.heigth(context) * .24,
                          left: 16,
                          right: 16),
                      decoration: BoxDecoration(
                          color: kwhiteColor,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                                color: kblackcolor.withOpacity(0.5),
                                blurRadius: 12)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: kgreenColor,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                kTextstyle(
                                    myText: "Contact us",
                                    myWeight: FontWeight.w600),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                inputFields("Name", _namec),
                                inputFields("Mobile Number", _numberc),
                                inputFields("Email", _email),
                                // inputFields("City", _cityc),
                                // inputFields("State", _state),
                                inputFields("Message", _message),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _sendMessage(_namec.text, _numberc.text,
                                      _email.text, _message.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Sending message'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      backgroundColor: kredColor,
                                      msg: 'Fill the form properly');
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 42,
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 56),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6)),
                              child: kTextstyle(
                                  myText: "Submit",
                                  myColor: kwhiteColor,
                                  myWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: screen.heigth(context) * 0.08,
                            width: screen.width(context) * .2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'),
                                    fit: BoxFit.cover)),
                          ),
                          kTextstyle(myText: "www.cloudtiffin.com", space: 1),
                          SizedBox(
                            height: 48,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column inputFields(name, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: kTextstyle(
              myText: name,
              mySize: 14,
              myColor: kblackcolor,
              myWeight: FontWeight.w600),
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: kgreyColor!.withOpacity(0.02),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: kgreenColor)),
          child: TextFormField(
            maxLines: null,
            keyboardType: (_numberc == controller)
                ? TextInputType.number
                : TextInputType.text,
            controller: controller,
            validator: (value) {
              if (value.toString().length != 0) {
              } else {
                return 'This field cannot be empty ';
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 12, right: 12, bottom: 2, top: 2)),
          ),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }

  Future<void> _sendMessage(name, number, email, message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('id');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/contact_request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userid",
        "name": "$name",
        "email": "$email",
        "message": "$message",
        "phone": "$number"
      }),
    );
    final data = json.decode(response.body);
    if (data['ResponseCode'] == "200") {
      Fluttertoast.showToast(
          backgroundColor: kgreenColor,
          textColor: kblackcolor,
          msg: 'message sent successfully');
      setState(() {
        _numberc.clear();
        _namec.clear();
        _email.clear();
        _message.clear();
      });
    } else {
      SnackBar(content: kTextstyle(myText: 'processing your request'));
      Fluttertoast.showToast(
          backgroundColor: kredColor, msg: 'Please try after some time');
    }
  }
}
