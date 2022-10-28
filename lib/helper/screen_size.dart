


import 'package:flutter/material.dart';


var kPadding = EdgeInsets.only(left: 16);
var kSizedBox1 = SizedBox(height: 12,);
var kSizedBox2 = SizedBox(height: 18,);
var kSizedBox3 = SizedBox(height: 24,);
class screen{
  static double heigth(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}