import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        shadowColor: Colors.white,
        automaticallyImplyLeading: false,
        backgroundColor: kwhiteColor,
        title: kTextstyle(myText: 'All Offers',myColor: kredColor,mySize: 18,myWeight: FontWeight.w600),
      ),
    );
  }
}
